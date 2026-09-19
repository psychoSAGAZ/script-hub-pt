import re
import os
import time
import translators as ts

MAIN_LUA_FILE = "script.lua"

# Mapeamento do código do idioma para o nome do arquivo
TARGET_LANGUAGES = {
    "en": "script-en.lua",
    "es": "script-es.lua",
    "fr": "script-fr.lua",
    "de": "script-de.lua",
    "it": "script-it.lua",
    "ja": "script-ja.lua",
    "ko": "script-ko.lua",
    "zh-CN": "script-zh-cn.lua",
    "zh-TW": "script-zh-tw.lua",
    "ru": "script-ru.lua",
    "tr": "script-tr.lua",
    "id": "script-id.lua"
}

def translate_batch(text_list, target_lang):
    """Traduz uma lista de textos alternando provedores se houver erro."""
    translated_dict = {}
    
    # Provedores gratuitos para tentar em ordem
    engines = ['bing', 'google', 'myMemory']
    
    for text in text_list:
        # Se o texto for apenas números, símbolos ou vazio, ignora
        if not text.strip() or text.isdigit() or len(text.strip()) <= 1:
            translated_dict[text] = text
            continue

        success = False
        for engine in engines:
            try:
                # Mapeamento especial de idioma para Bing se necessário
                lang_code = target_lang
                if target_lang == "zh-CN": lang_code = "zh-Hans"
                if target_lang == "zh-TW": lang_code = "zh-Hant"

                res = ts.translate_text(
                    text, 
                    translator=engine, 
                    from_language='pt', 
                    to_language=lang_code
                )
                translated_dict[text] = str(res)
                success = True
                time.sleep(0.1) # Pequena pausa de segurança
                break
            except Exception as e:
                continue

        # Se todos os servidores falharem para essa palavra, mantém o texto original
        if not success:
            print(f"Aviso: Não foi possível traduzir '{text}'")
            translated_dict[text] = text

    return translated_dict

def translate_lua_script(lua_code, target_lang):
    # Regex para capturar os textos dos campos visuais
    pattern = r'((?:Title|Message|Name|Text|Content)\s*=\s*")([^"]+)(")'
    
    # 1. Encontra todas as frases/textos únicos para traduzir
    matches = re.findall(pattern, lua_code)
    unique_texts = list(set([m[1] for m in matches]))
    
    # 2. Traduz em lote
    translations = translate_batch(unique_texts, target_lang)

    # 3. Substitui no script Lua mantendo a estrutura
    def replace_match(match):
        prefix = match.group(1)
        original_text = match.group(2)
        suffix = match.group(3)
        
        translated_text = translations.get(original_text, original_text)
        return f'{prefix}{translated_text}{suffix}'

    return re.sub(pattern, replace_match, lua_code)

def main():
    if not os.path.exists(MAIN_LUA_FILE):
        raise FileNotFoundError(f"Arquivo {MAIN_LUA_FILE} não encontrado.")

    with open(MAIN_LUA_FILE, "r", encoding="utf-8") as f:
        original_lua = f.read()

    for lang_code, filename in TARGET_LANGUAGES.items():
        print(f"Traduzindo para {lang_code} ({filename})...")
        
        translated_lua = translate_lua_script(original_lua, lang_code)

        with open(filename, "w", encoding="utf-8") as f:
            f.write(translated_lua)
            
        print(f"Concluído: {filename}")
        time.sleep(1) # Pausa entre cada arquivo de idioma

if __name__ == "__main__":
    main()
