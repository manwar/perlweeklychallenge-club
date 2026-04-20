#!/opt/homebrew/bin/gawk


#
# Loop over each line of input
#
{
    str     = $1
    size    = $2
    filler  = $3

    out_len = 0

    #
    # Add the filler to the string, size - 1 times
    #
    for (i = 1; i < size; i ++) {
        str = str filler
    }

    #
    # Chop the string into substrings of length size,
    # and add them to the out array
    #
    # If at the end str has characters left, they 
    # will be filler characters
    #
    while (length (str) >= size) {
        out [out_len ++] = substr (str, 1, size)
        str = substr (str, size + 1)
    }

    #
    # Print the result
    #
    for (i = 0; i < out_len; i ++) {
        printf ("%s%s", out [i], i == out_len - 1 ? "\n" : " ");
    }
}
