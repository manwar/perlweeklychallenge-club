#!/opt/homebrew/bin/gawk

#
# Loop over each line of input
#
{
    split ($0, chars, "")
    max = -1
    sec = -1
    for (i = 1; i <= length (chars); i ++) {
        ch = chars [i]
        if (ch ~ /[0-9]/) {
            if (max < ch)             {sec = max; max = ch}
            if (max > ch && ch > sec) {sec = ch}
        }
    }
    print sec
}
