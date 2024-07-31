#!/bin/bash

# Массив с названиями столбцов и их значений
columns=(
      TZ=$(cat /etc/timezone)
      OS_NAME=$(grep -E '^NAME' /etc/os-release | sed 's/NAME=//' | sed 's/"//g')
      OS_VERSION=$(grep "VERSION=" /etc/os-release | cut -c10- | sed 's/\(([a-zA-Z ]*)*\)"//g' | sed 's/ $//')
      DATE=$(date +"%d %B %Y %T")
      UPTIME=$(uptime -p | cut -c4-)
      UPTIME_SEC=$(awk '{print $1}' /proc/uptime)
      IP=$(hostname -I | awk '{print $1}')
      MASK=$(ip address show | grep -E 'inet' | grep -m1 'brd' | awk '{print $4}')
      GATEWAY=$(ip route | grep default | awk '{print $3}')
      RAM_TOTAL=$(free | grep -P 'Mem|Память' | awk '{printf "%.3f GB", $2/1024/1024}')
      RAM_USED=$(free | grep -P 'Mem|Память' | awk '{printf "%.3f GB", $3/1024/1024}')
      RAM_FREE=$(free | grep -P 'Mem|Память' | awk '{printf "%.3f GB", $4/1024/1024}')
      SPACE_ROOT=$(df | grep '/$' | awk '{printf "%.2f MB", $2/1024}')
      SPACE_ROOT_USED=$(df | grep '/$' | awk '{printf "%.2f MB", $3/1024}')
      SPACE_ROOT_FREE=$(df | grep '/$' | awk '{printf "%.2f MB", $4/1024}')
)

# Функция для вывода сообщения о проблеме с параметрами
show_error_message() {
    echo "Ошибка: Параметры цветов совпадают. Пожалуйста, укажите различные цвета."
    echo "Пример использования: ./main.sh 1 3 4 5"
}

# Функция для вывода информации с применением выбранных цветов
colorize_output() {
    bg_colors=($(tput setab $1) $(tput setab $3))
    txt_colors=($(tput setaf $2) $(tput setaf $4))
    reset=$(tput sgr0) # Сброс цветов

    for column in "${columns[@]}"; do
        col_name=$(echo "$column" | cut -d'=' -f1)
        col_value=$(echo "$column" | cut -d'=' -f2)

        # Изменение цвета для каждого столбца
        echo -e "${bg_colors[0]}${txt_colors[0]}$col_name =${reset} ${bg_colors[1]}${txt_colors[1]}$col_value${reset}"
    done
}

# Проверка на совпадение цветов
if [ "$1" == "$3" ] || [ "$2" == "$4" ]; then
    show_error_message
    exit 1
fi

# Вызов функции для вывода информации с применением цветов
colorize_output "$@"
