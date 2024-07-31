#!/bin/bash

# not equal - 0(если 2 числа не равны,check_match 0)
# equal - 1
function check_match {
    if [ $1 -eq $2 ] #Это условное выражение, которое сравнивает значение первого аргумента $1 с вторым аргументом $2. Если они равны (сравнение с помощью -eq), то выполняется следующая строка
    then result=1 #Если условие в строке 5 истинно (числа равны), то переменной result присваивается значение 1
    else result=0
    fi
    echo $(( $result ))
}

function check_range { #Это условное выражение, которое проверяет, что значение первого аргумента $1 находится в диапазоне от 1 до 6 (включительно)
    if [ $1 -ge 1 ] && [ $1 -le 6 ]
    then return 1
    else return 0
    fi
}

function check_values { #Вызываются функции check_range для проверки каждого из четырех аргументов. Результаты каждой проверки сохраняются в переменной result с учетом предыдущего значения result. Результаты проверок умножаются между собой
    result=1

    check_range $1
    result=($result*$?)

    check_range $2
    result=($result*$?)

    check_range $3
    result=($result*$?)

    check_range $4
    result=($result*$?)

    return $(( $result ))
}