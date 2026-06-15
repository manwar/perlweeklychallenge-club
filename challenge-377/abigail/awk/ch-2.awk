#!/opt/homebrew/bin/gawk


#
# Loop over each line of input
#
{
    count = 0
    for (i = 1; i < NF; i ++) {
        for (j = i + 1; j <= NF; j ++) {
            w1 = $i
            w2 = $j
            if (length (w2) > length (w1)) {
                w1 = $j
                w2 = $i
            }
            if (index (w1, w2) == 1 && 
                           w2  == substr (w1, length (w1) - length (w2) + 1)) {
                count ++
            }
        }
    }
    print count
}
