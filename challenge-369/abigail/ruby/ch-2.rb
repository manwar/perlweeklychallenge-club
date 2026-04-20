#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    #
    # Parse input
    #
    parts  = line . rstrip . split " "
    str    = parts [0]
    size   = parts [1] . to_i
    filler = parts [2]

    #
    # Add 'size - 1' times the filler character to the string
    #
    str   += filler * (size - 1)

    #
    # While we have at least size characters left in str, take the first
    # size characters and add them to the output array
    #
    out = []
    while str . length >= size
        out . push str [0, size]
        str [0, size] = ""
    end

    #
    # Print the result
    #
    puts out . join " "
}
