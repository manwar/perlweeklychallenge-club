# run for example as:
# echo '3 1 4 2 3 5
#      4 9 0 6 2 3 85 ' | awk -f trim_list.awk

{
    i = $1
    printf "Input = %-18s- i = %d   => result = ", $0, $1
    for (j = 2; j <= NF; j++) {
        if ( $j > i) {
            printf "%d ", $j
        }
    }
    print ""
}
