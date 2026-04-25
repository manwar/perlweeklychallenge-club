#!/opt/homebrew/bin/gawk


#
# Return 1 if both str1 and str2 contain the same letters.
#
function are_anagrams(str1, str2,  chars, s_str1, s_str2, i, n) {
    #
    # Sort the characters found in str1/str2, then compare
    #
    delete chars
    n = split (str1, chars, "")
    asort (chars)
    for (i = 1; i <= n; i ++) {s_str1 = s_str1 chars [i]}  # Join

    delete chars
    n = split (str2, chars, "")
    asort (chars)
    for (i = 1; i <= n; i ++) {s_str2 = s_str2 chars [i]}  # Join

    return s_str1 == s_str2
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
