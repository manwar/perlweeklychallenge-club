#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }

    #
    # Split the line of input, and turn the substrings into numbers
    #
    numbers <- as.numeric ((strsplit (line, " ")) [[1]])

    #
    # Iterate over all possible masks, except all 0s and all 1s
    #
    for (mask in 1 : (2 ^ length (numbers) - 2)) {
        sum <- 0
        set <- c ()
        for (index in 1 : length (numbers)) {
            #
            # If the position of a number is in the mask, add the difference
            # of the number and its position to the sum, and add the
            # number to the current set
            #
            if (bitwAnd (mask, bitwShiftL (1, (index - 1)))) {
                sum <- sum + numbers [[index]] - index
                set <- c (set, numbers [[index]])
            }
        }
        #
        # Print the set if the sum equals 0, and if there are
        # more than 1 element in the set
        #
        if (sum == 0 && length (set) > 1) {
            cat (paste (set, collapse = " "), "; ", sep = "")
        }
    }
    cat ("\n")
}
