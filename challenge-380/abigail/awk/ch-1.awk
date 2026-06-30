#!/opt/homebrew/bin/gawk

BEGIN {
    FS = ""
}

#
# Loop over each line of input
#
{
    delete chars;
    for (i = 1; i <= NF; i ++) {
        if ("a" <= $i && $i <= "z") {
            chars [$i] ++
        }
    }
    max_c = 0
    max_v = 0
    for (ch in chars) {
        count = chars [ch]
        if (ch == "a" || ch == "e" || ch == "i" || ch == "o" || ch == "u") {
            if (max_v < count) {max_v = count}
        }
        else {
            if (max_c < count) {max_c = count}
        }
    }
    print max_c + max_v
}
