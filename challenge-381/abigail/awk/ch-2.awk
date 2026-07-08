#!/opt/homebrew/bin/gawk


{
    min_c = max_c = 0
    for (i = 1; i <= NF; i ++) {
        if (!min_c || $i < min) {min_c = 0; min = $i}
        if (!max_c || $i > max) {max_c = 0; max = $i}
        if ($i == min)          {min_c ++}
        if ($i == max)          {max_c ++}
    }
    print NF - min_c - (min == max ? 0 : max_c)
}
