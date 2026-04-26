#!/opt/homebrew/bin/gawk


#
# Loop over each line of input
#
{
    split ($0, parts, "//")

    #
    # Split the banned words on spaces. This makes banned an array
    # with banned words
    #
    delete banned
    split (tolower (parts [2]), banned)

    #
    # Make banned an associative array: iterate over the indices of
    # the array, add the value as an index, then delete the index.
    # Now we just map banned words to true values
    #
    for (ban in banned) {
        banned [banned [ban]] = 1
        delete  banned [ban]
    }

    #
    # Lower case the paragraph, change all non-letter sequences to single
    # spaces, and split on space. This makes words an array with the
    # lower case words.
    #
    paragraph = gensub (/[^[:alpha:]]+/, " ", "g", tolower (parts [1]))
    split (paragraph, words)

    #
    # Iterate over the words.
    # If the word isn't banned, count it in the ok array
    #
    delete ok
    for (i in words) {
        word = words [i]
        if (!(word in banned)) {
            ok [word] ++
        }
    }

    #
    # Find the most frequently occurring word
    #
    max = ""
    for (word in ok) {
        if (ok [word] > ok [max]) {
            max = word
        }
    }
    print max
}
