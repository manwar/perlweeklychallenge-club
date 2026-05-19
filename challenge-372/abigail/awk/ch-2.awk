#!/opt/homebrew/bin/gawk


#
# Loop over each line of input
#
{
    split ($0, chars, "")   # chars is array of characters, sans the newline
    max = -1                # Track the max difference
    for (f = 1; f <= length (chars); f ++) {    # For each character,
        for (l = length (chars); l > f; l --) { # find matching character
            if (chars [f] == chars [l]) {       # from the end.
                if (l - f - 1 > max) {          # If larger difference,
                    max = l - f - 1             # remember it.
                }
                break
            }
        }
    }
    print max
}
