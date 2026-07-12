#!/opt/homebrew/bin/gawk

BEGIN {r = 1}

NR == 1 {N = NF}

{
    for (i = 1; i <= N; i ++) {
        if ($i < 1 || $i > N) {r = 0}
        matrix [NR, i] = $i
    }
}

END {
    for (i = 1; i <= N; i ++) {
        delete row
        delete column
        for (j = 1; j <= N; j ++) {
            row [matrix [i, j]] = column [matrix [j, i]] = 1
        }
        if (length (row) != N || length (column) != N) {r = 0}
    }
            
    print r ? "true" : "false"
}
