echo '1 2 3
4 5 6 '  | bash -c '
    read -a a1
    read -a a2
    for ((i = 0; i < ${#a1[@]}; i ++))
        do  ((result += a1[i] * a2[i]))
    done
    echo $result
'

