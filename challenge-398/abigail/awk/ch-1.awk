#!/opt/homebrew/bin/gawk

function round (x) {r = x >= 0 ? int (x + .5) : int (x - .5); return r}

#
# Loop over each line of input
#
{
    sum   = 0
    count = 0
    for (i = 1; i <= NF; i ++) {
        if ($i % 6 == 0) {
            sum += $i
            count ++
        }
    }
    print sum ? round(sum / count) : 0
}
