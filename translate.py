import re
import os
import time
from deep_translator import GoogleTranslator

MAIN_LUA_FILE = "script.lua"

# Mapeamento do código do idioma para o nome exato do arquivo
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

def translate_visual_content(lua_code, lang_code):
    translator = GoogleTranslator(source='pt', target=lang_code)
    
    # Dicionário de cache para evitar traduzir a mesma palavra várias vezes
    cache = {}

    # Captura textos apenas em propriedades visuais da UI
    pattern = r'((?:Title|Message|Name|Text|Content)\s*=\s*")([^"]+)(")'

    def replace_match(match):
        prefix = match.group(1)
        text = match.group(2)
        suffix = match.group(3)
        
        # Se for um texto muito curto ou apenas símbolos/números, ignora
        if not text.strip() or len(text.strip()) <= 1 or text.isdigit():
            return f'{prefix}{text}{suffix}'

        # Se já traduziu essa frase antes, usa a resposta do cache
        if text in cache:
            return f'{prefix}{cache[text]}{suffix}'

        # Tenta traduzir com pequenas tentativas em caso de bloqueio temporário
        for attempt in range(3):
            try:
                translated = translator.translate(text)
                cache[text] = translated
                time.sleep(0.3)  # Pausa de 0.3s para evitar limite de requisições
                return f'{prefix}{translated}{suffix}'
            except Exception as e:
                if attempt == 2:
                    print(f"Erro ao traduzir '{text}': {e}")
                    return f'{prefix}{text}{suffix}'
                time.sleep(1.5)  # Aguarda 1.5s antes de tentar novamente

        return f'{prefix}{text}{suffix}'

    return re.sub(pattern, replace_match, lua_code)

def main():
    if not os.path.exists(MAIN_LUA_FILE):
        raise FileNotFoundError(f"O arquivo {MAIN_LUA_FILE} não foi encontrado na raiz do repositório.")

    with open(MAIN_LUA_FILE, "r", encoding="utf-8") as f:
        original_lua = f.read()

    for lang_code, filename in TARGET_LANGUAGES.items():
        print(f"Traduzindo para {lang_code} ({filename})...")
        
        translated_lua = translate_visual_content(original_lua, lang_code)
        output_path = filename 

        with open(output_path, "w", encoding="utf-8") as f:
            f.write(translated_lua)
            
        print(f"Salvo em: {output_path}")
        time.sleep(1)  # Pausa entre cada idioma

if __name__ == "__main__":
    main()
