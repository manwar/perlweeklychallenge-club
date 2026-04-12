#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    parts = line . rstrip . split (" ")
    input = parts [0]
    digit = parts [1]

    n = 0

    #
    # Remove the first occurrence of the digit where it is followed 
    # by a larger digit. We're using "sub! (pat) {block}" so we can
    # set a flag indicating the substitution has happened.
    #
    if digit != "9"
        pat = Regexp . new digit + "(?=[" + (digit . to_i + 1) . to_s + "-9])"
        input.sub!(pat) {n = 1; ""}
    end

    #
    # If the above substition didn't happen, remove the last occurrence
    # of the digit in the input.
    #
    if n == 0
        pat = Regexp . new "(.*)" + digit
        input.sub! pat, "\\1"
    end

    puts input
}
