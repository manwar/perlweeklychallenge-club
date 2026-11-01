#!/opt/homebrew/bin/gawk


{
    sum = 0
    delete array
    for (i = 1; i <= NF; i ++) {
        sum += $i
        array [$i] = 1
    }
    for (res = sum <= 0 ? 1 : 1 + int (sum / NF); array [res]; res ++) {1}
    print res
}
