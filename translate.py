import re
import os
from deep_translator import GoogleTranslator

MAIN_LUA_FILE = "script.lua"

# Mapeamento do código do idioma para o nome exato do arquivo que você criou
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

    # Captura textos apenas em propriedades visuais da UI
    pattern = r'((?:Title|Message|Name|Text|Content)\s*=\s*")([^"]+)(")'

    def replace_match(match):
        prefix = match.group(1)
        text = match.group(2)
        suffix = match.group(3)
        
        try:
            translated = translator.translate(text)
        except Exception as e:
            print(f"Erro ao traduzir '{text}': {e}")
            translated = text
            
        return f'{prefix}{translated}{suffix}'

    return re.sub(pattern, replace_match, lua_code)

def main():
    if not os.path.exists(MAIN_LUA_FILE):
        raise FileNotFoundError(f"O arquivo {MAIN_LUA_FILE} não foi encontrado na raiz do repositório.")

    with open(MAIN_LUA_FILE, "r", encoding="utf-8") as f:
        original_lua = f.read()

    for lang_code, filename in TARGET_LANGUAGES.items():
        print(f"Traduzindo para {lang_code} ({filename})...")
        
        translated_lua = translate_visual_content(original_lua, lang_code)

        # Se os arquivos estiverem em uma pasta (ex: locales/script-en.lua), ajuste o caminho abaixo
        output_path = filename 

        with open(output_path, "w", encoding="utf-8") as f:
            f.write(translated_lua)
            
        print(f"Salvo em: {output_path}")

if __name__ == "__main__":
    main()
