{
    #
    # Initialize
    #
    is_palindrome = 0
}

/^[0-9]+(\.[0-9]+)?$/ {
    #
    # If it looks like an unsigned number, check whether
    # it's a palindrome.
    #
    is_palindrome = 1
    for (i = 1; i <= length / 2; i ++) {
        s1 = substr($0, i, 1)
        s2 = substr($0, length - i + 1, 1)
        if (s1 != s2) {
            is_palindrome = 0
        }
    }
}

{
    #
    # Print result
    #
    print is_palindrome
}
