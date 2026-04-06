#!/opt/homebrew/bin/gawk


#
# Loop over each line of input
#
{
    line  = $1
    digit = $2

    n = split (line, chars, "")

    matched = 0
    #
    # Find the first occurrence of the digit followed by a larger
    # digit -- remove this digit.
    #
    for (i = 1; i < n; i ++) {
        if (chars [i] == digit && chars [i + 1] > digit) {
            chars [i] = ""
            matched   = 1
            break
        }
    }
    #
    # Did not find a match, find the first occurrence of the digit
    # from the end -- remove this digit
    #
    if (matched == 0) {
        for (i = n; i >= 1; i --) {
            if (chars [i] == digit) {
                chars [i] = ""
                break
            }
        }
    }

    #
    # Print the result
    #
    for (i in chars) {
        printf "%s", chars [i]
    }
    printf "\n"
}
