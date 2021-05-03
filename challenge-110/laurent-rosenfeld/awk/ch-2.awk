BEGIN{
    FS = ","
}
{ table[0,NR] = $1 }
{ table[1,NR] = $2 }
{ table[2,NR] = $3 }
{ max = NR }
END {
    for (i = 0; i < 3; i++) {
        for (j = 1; j < max - 1; j++) printf "%s,", table[i,j]
        printf "%s\n", table[i,max-1]
    }
}
