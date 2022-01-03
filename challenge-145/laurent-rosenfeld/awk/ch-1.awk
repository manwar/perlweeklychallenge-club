echo '1 2 3
4 5 6 '  | awk -e '{
    for (i = 1; i <= NF; i ++) {
        if (NR == 1) {
             col[i] = $i
        }
        else {
            result += col[i] * $i
        }
    }
}
END {
    print result
}
'
