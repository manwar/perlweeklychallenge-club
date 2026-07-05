#!/opt/homebrew/bin/Rscript

ord_a <- utf8ToInt ("a")
ord_z <- utf8ToInt ("z")

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    #
    # Initialize the counting array
    #
    chars <- c ()
    for (i in 1 : (ord_z - ord_a + 1)) {
        chars [[i]] <- 0
    }

    #
    # Parse a line of input, count frequency
    #
    for (ch in (strsplit (line, "")) [[1]]) {
        if (ord_a <= utf8ToInt (ch) && utf8ToInt (ch) <= ord_z) {
            index <- utf8ToInt (ch) - ord_a + 1
            chars [[index]] = chars [[index]] + 1
        }
    }

    #
    # Find maximum frequencies of vowels and consonant
    #
    max_c <- 0
    max_v <- 0

    for (i in 1 : (ord_z - ord_a + 1)) {
        ch    <- intToUtf8 (i + ord_a - 1)
        count <- chars [[i]]
        if (ch == "a" || ch == "e" || ch == "i" || ch == "o" || ch == "u") {
            if (max_v < count) {max_v <- count}
        }
        else {
            if (max_c < count) {max_c <- count}
        }
    }

    cat (max_c + max_v, "\n")
}
