#!/bin/bash

# Проверка на количество параметров
if [ "$#" -ne 4 ]; then
    echo "Ошибка: Неверное количество параметров."
    echo "Пример использования: ./main.sh 1 3 4 5"
    exit 1
fi

# Проверка на ввод числовых параметров от 1 до 6
for param in "$@"; do
    if ! [[ "$param" =~ ^[1-6]$ ]]; then
        echo "Ошибка: Параметры должны быть числовыми от 1 до 6."
        exit 1
    fi
done

# Запуск скрипта с цветовой настройкой
./colorized_output.sh "$@"