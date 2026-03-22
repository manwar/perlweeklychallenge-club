#!/opt/homebrew/bin/gawk

#
# Loop over each line of input
#
{
    valid = 0
    for (i = 1; i <= NF; i ++) {
        if (match ($i, /^([a-z]+(-[a-z]+)?)?[!.,]?$/)) {
            valid ++
        }
    }
    print valid
}
