#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }

    #
    # Split the input on whitespace. First element is the number of sets
    #
    list <- (strsplit (line, " ")) [[1]]
    n    <- as.numeric (list [[1]])
    list <- list [-1]

    #
    # Special case if n exceeds the length of the list
    #
    if (n > length (list)) {
        cat ("-1;\n")
        next
    }

    #
    # Calculate the size of the sets, and the number of sets
    # which gets one more
    #
    per_set  <- length (list) %/% n
    overflow <- length (list)  -  n * per_set

    #
    # Print the sets
    #
    for (i in 1 : n) {
        #
        # Calculate the size of the current set
        #
        set_size <- per_set
        if (i <= overflow) {
            set_size <- set_size + 1
        }
        #
        # Print current set
        #
        cat (paste (list [1 : set_size], collapse = " "))
        cat ("; ")
        #
        # Adjust list
        #
        list <- list [set_size + 1 : length (list)]
    }
    cat ("\n")
}
