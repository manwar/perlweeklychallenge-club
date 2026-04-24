#!/opt/homebrew/bin/gawk


#
# Return 1 if both str1 and str2 contain the same letters.
# It is given that str1 and str2 are of the same length
#
function are_anagrams(str1, str2,  chars, hist1, hist2, ch) {
    #
    # Make a histogram of the letters in str1
    #
    delete chars
    delete hist1
    split (str1, chars)
    for (ch in chars) {
        hist1 [ch] ++
    }

    #
    # Make a histogram of the letters in str2
    #
    delete chars
    delete hist2
    split (str2, chars)
    for (ch in chars) {
        hist2 [ch] ++
    }

    #
    # Compare frequency. If any are off, the strings don't have the
    # same letters. If all pass, they do.
    #
    for (ch in hist1) {
        if (hist1 [ch] != hist2 [ch]) {
            return 0
        }
    }
    return 1
}

function can_scramble(input, target,  l, m) {
    #
    # If both strings are equal, they scramble into each other trivially
    #
    if (input == target) {
        return 1
    }

    #
    # If the strings are of unequal length, they cannot scramble
    # into each other
    #
    if (length (input) != length (target)) {
        return 0
    }

    #
    # If the strings don't have the same letters, they cannot scramble
    # into each other
    #
    if (!are_anagrams(input, target)) {
        return 0
    }

    #
    # For each length, try splitting and recursing both halves; once not
    # swapped, and once swapped
    #
    for (l = 1; l < length (input); l ++) {
        m = length (input) - l
        if (can_scramble(substr (input, 1,     l), substr (target, 1,     l)) &&
            can_scramble(substr (input, l + 1, m), substr (target, l + 1, m)) ||
            can_scramble(substr (input, l + 1, m), substr (target, 1,     m)) &&
            can_scramble(substr (input, 1,     l), substr (target, m + 1, l))) {
            return 1
        }
    }

    return 0
}

#
# Loop over each line of input
#
{
    print can_scramble($1, $2) ? "true" : "false"
}
