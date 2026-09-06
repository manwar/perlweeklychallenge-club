#!/opt/homebrew/bin/gawk


{
    printf "%s => ", toupper ($1)
    for (i = 1; i <= NF / 2; i ++) {out [$(i + (NF + 1) / 2)] = $(i + 1)}
    for (i = 1; i <= NF / 2; i ++) {printf "%s ", out [i]}
    print ""
}
