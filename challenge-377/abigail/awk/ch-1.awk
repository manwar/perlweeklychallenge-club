#!/opt/homebrew/bin/gawk


#
# Loop over each line of input
#
{
    for (i = 1; i < length ($0); i ++) {
        #
        # For each character, prepend it with the next character, and
        # check whether the result is present in the input line. If so,
        # print 'true', and continue with the next line of input.
        #
        if (index ($0, substr ($0, i + 1, 1) substr ($0, i, 1))) {
            print "true"
            next
        }
    }
    #
    # No match
    #
    print "false"
}
