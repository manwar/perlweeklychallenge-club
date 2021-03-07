#!/opt/local/bin/gawk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.gawk < input-file
#


BEGIN {
    #
    # Parse command line
    #
    for (i = 1; i < ARGC; i ++) {
        if (ARGV [i] == "-f") {
            filename = ARGV [i + 1]
        }
    }
    ARGC = 0

    #
    # Read in the words
    #
    i = 1
    while ((getline word < filename) > 0) {
        words [i ++] = word
    }

    #
    # So we do lower case matching. Note that this is a GNU AWK extension
    #
    IGNORECASE = 1
}


{
    #
    # Split each line into characters. Then, for each word in
    # the word list, remove each of the characters from the split
    # line. If we end up with an empty string, we have a winner.
    #
    split ($0, chars, "")
    for (i = 1; i <= length (words); i ++) {
        copy = words [i]
        for (j = 1; j <= length (chars); j ++) {
            sub (chars [j], "", copy)
        }
        if (length (copy) == 0) {
            print words [i]
        }
    }
}
