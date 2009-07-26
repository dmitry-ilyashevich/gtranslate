# gtranslate

This is a simple module for Google Translate service

Usage:

    text = "Привет, Мир!"
    GTranslate.detect(text) # => "ru"
    GTranslate.translate(text, 'fr') # => "Bonjour, monde!"
    GTranslate.tag(text, "_") # => "hello_world"

## Copyright

Copyright (c) 2009 Dmitry A. Ilyashevich. See LICENSE for details.
