#!/opt/homebrew/bin/Rscript

ord_a <- utf8ToInt ("a")
ord_0 <- utf8ToInt ("0")

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    #
    # Split the input string into separate characters; then
    # change letters to digits
    #
    chars <- (strsplit (line, split = "")) [[1]]
    for (i in 1 : length (chars)) {
        ch <- chars [[i]]
        if ("a" <= ch && ch <= "j") {
            chars [[i]] <- intToUtf8 (utf8ToInt (ch) - ord_a + ord_0)
        }
    }

    #
    # Join the characters back into a string; split on spaces, 
    # and make the parts numeric
    #
    numbers <- sapply ((strsplit (paste (chars, collapse = ""),
                                  split = " ")) [[1]], as.numeric)

    #
    # Name the parts, and check the sum
    #
    n1  <- numbers [[1]]
    n2  <- numbers [[2]]
    sum <- numbers [[3]]
    if (n1 + n2 == sum) {
        cat ("true\n")
    }
    else {
        cat ("false\n")
    }
}
