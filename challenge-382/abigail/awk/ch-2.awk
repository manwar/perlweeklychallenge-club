#!/opt/homebrew/bin/gawk


{
    delete todo
    todo [1] = $1
    for (i = n = 1; i <= n; i ++) {
        if (todo [i] ~ /\?/) {
            todo [++ n] = todo [i]; sub (/\?/, 0, todo [n])
            todo [++ n] = todo [i]; sub (/\?/, 1, todo [n])
        }
        else {
            printf ("%s ", todo [i])
        }
    }
    printf ("\n")
}
