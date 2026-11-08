#!/opt/homebrew/bin/gawk

@load "ordchr"

function Next (i, max) {return i >= max ?   1 : i + 1}
function Prev (i, max) {return i <=   1 ? max : i - 1}

#
# Loop over each line of input
#
{
    delete diffs
    for (i = 1; i <= NF; i ++) {
        offset  = ord(substr ($i, 1, 1)) - ord("a")
        shifted = ""
        for (j = 1; j <= length ($i); j ++) {
            shifted = shifted chr(ord(substr ($i, j, 1)) - offset)
        }
        diffs [i] = shifted
    }
    for (i = 1; i <= NF; i ++) {
        if (diffs [i] != diffs [Next(i, NF)] &&
            diffs [i] != diffs [Prev(i, NF)]) {
            print $i
            break
        }
    }
}
