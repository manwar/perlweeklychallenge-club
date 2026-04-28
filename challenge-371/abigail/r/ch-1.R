#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    #
    # Split the input line on white space; strip a layer.
    # Create an empty list for the code points
    #
    letters <- (strsplit (line, " ")) [[1]]
    cpoints <- c ()

    #
    # Find the position of the question mark. Store the code points
    # of the letters in cpoints.
    #
    for (i in 1 : 5) {
        if (letters [[i]] == "?") {
            qi <- i
        }
        cpoints [[i]] = utf8ToInt (letters [[i]])
    }

    #
    # Get values needed to calculate the missing character
    #
    base <- cpoints [[if (qi <= 3) qi + 1 else                          qi - 1]]
    from <- cpoints [[if (qi <  3) qi + 3 else if (qi == 3) qi - 1 else qi - 3]]
    to   <- cpoints [[if (qi <  3) qi + 2 else                          qi - 2]]

    #
    # Calculate the missing character and print it
    #
    cat (intToUtf8 (base - from + to), "\n")
}
