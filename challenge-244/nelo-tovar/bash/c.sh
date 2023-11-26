list=(2 1 4)

combinations() {
    local -a results=()
    let idx=$2
    for (( j = 0; j < $1; j++ )); do
            if (( idx % 2 )); then results=("${results[@]}" "${list[$j]}"); fi
                let idx\>\>=1
                done
                echo "${results[@]}"
}

n=${#list[@]}
for (( i = 1; i < 2**n; i++ )); do
    combinations $n $i
done
