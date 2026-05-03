#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|

    #
    # Read the letters, store their character values in letters
    #
    letters = line . rstrip . split . map(&:ord)

    #
    # Find the index of the question mark
    #
    qi = 0
    letters . each_with_index {
        |val, index|
        if val == "?" . ord
            qi = index
            break
        end
    }

    #
    # Get the values needed to calculate the missing character
    #
    base = letters [qi <= 2 ? qi + 1 :                    qi - 1]
    from = letters [qi <  2 ? qi + 3 : qi == 2 ? qi - 1 : qi - 3]
    to   = letters [qi <  2 ? qi + 2 :                    qi - 2]

    #
    # Calculate the missing character and print it
    #
    puts (base - from + to) . chr
}
