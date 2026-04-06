#!/opt/homebrew/bin/gawk


#
# Loop over each line of input
#
{
    count0 = 0
    count1 = 0
    #
    # Split the input into an array of characters
    #
    n = split ($0, chars, "")

    #
    # Count the number of 1's and 0's
    #
    for (i = 1; i <= n; i ++) {
        if (chars [i] == 0) {count0 ++}
        if (chars [i] == 1) {count1 ++}
    }

    #
    # Print all but one of the 1's
    #
    for (i = 2; i <= count1; i ++) {printf 1}

    #
    # Print all 0's
    #
    for (i = 1; i <= count0; i ++) {printf 0}

    #
    # Print the remaining 1
    #
    print 1
}
