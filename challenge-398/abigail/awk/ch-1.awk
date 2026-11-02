#!/opt/homebrew/bin/gawk


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
    print sum ? int (.5 + sum / count) : 0
}
