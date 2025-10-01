#!/bin/bash
# Instala o Jupyter Notebook
pip install jupyter

# Atualiza o Jupyter Notebook
pip install --upgrade notebook

# Instala as extensões do Jupyter e seu configurador
pip install jupyter_nbextensions_configurator
pip install jupyter_contrib_nbextensions
pip install notebook==6.4.3

# Instala as extensões do Jupyter
jupyter contrib nbextension install --system

# Ativa extensões individuais
jupyter nbextension enable contrib_nbextensions_help_item/main
jupyter nbextension enable autosavetime/main
jupyter nbextension enable codefolding/main
jupyter nbextension enable code_font_size/code_font_size
jupyter nbextension enable code_prettify/code_prettify
jupyter nbextension enable collapsible_headings/main
jupyter nbextension enable comment-uncomment/main
jupyter nbextension enable equation-numbering/main
jupyter nbextension enable execute_time/ExecuteTime
jupyter nbextension enable gist_it/main
jupyter nbextension enable hide_input/main
jupyter nbextension enable spellchecker/main
jupyter nbextension enable toc2/main
jupyter nbextension enable toggle_all_line_numbers/main

# Reinstala o traitlets para evitar conflitos de versão
pip install --force-reinstall -v "traitlets<5.10"
