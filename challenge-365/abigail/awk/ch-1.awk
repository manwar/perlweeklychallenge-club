#!/opt/homebrew/bin/gawk


BEGIN {
    #
    # Make a mapping from character ('a' .. 'z') to its index (1 .. 26)
    #
    ord_a =  97
    ord_z = 122
    for (i = ord_a; i <= ord_z; i ++) {
        chr = sprintf ("%c", i)
        ord [chr] = i - ord_a + 1
    }
}

#
# Given a number (as a string), return the sum of its digits (as a string)
#
function digit_sum (str, sum, n, i) {
    n = split (str, digits, //)
    sum = 0
    for (i = 1; i <= n; i ++) {
        sum = sum + strtonum (digits [i])
    }
    return sum
}

#
# Loop over each line of input
#
{
    str   = $1
    count = $2

    #
    # Translate the input to a number string
    #
    n  = split (str, letters, //)
    digit_str = ""
    for (i = 1; i <= n; i ++) {
        digit_str = digit_str ord [letters [i]]
    }
    #
    # Repeatedly calculate the digit sum
    #
    for (i = 1; i <= count; i ++) {
        digit_str = digit_sum(digit_str)
    }
    print digit_str
}
