#!/opt/homebrew/bin/awk

BEGIN {
    ord_A = 97
}

    {
        for (i = 10; i <= 26; i ++) {
            #
            # Replace NN# with 10 <= NN <= 26 with the corresponding character
            #
            sub (i "#", sprintf ("%c", ord_A - 1 + i))
        }
        for (i = 1; i <= 9; i ++) {
            #
            # Replace N with 1 <= N <= 9 with the corresponding character
            #
            sub (i,     sprintf ("%c", ord_A - 1 + i))
        }
        print
    }
