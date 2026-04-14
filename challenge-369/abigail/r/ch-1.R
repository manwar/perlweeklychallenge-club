#!/opt/homebrew/bin/Rscript


stdin <- file ('stdin', 'r')
repeat {
    input <- readLines (stdin, n = 1)
    if (length (input) == 0) {
        break
    }

    input <-  sub ("^\\s+", "", input)               # Remove leading space
    input <- gsub ("[^[:space:][:alpha:]]+",         # Remove non-letters, but
                            "", input)               # keep spaces
    input <-  sub ("\\s+$", "", input)               # Remove trailing space
    input <- tolower (input)                         # Lower case entire string

    ptr   <- utf8ToInt ("a")                         # Loop over all 
    end   <- utf8ToInt ("z")                         # lower case letters
    while (ptr <= end) {
        ch    <- intToUtf8 (ptr)                     # Replace space followed
        input <- gsub (paste ("\\s+", ch, sep = ""), # by letter with its upper
                             toupper (ch), input)    # case, dropping the space
        ptr   <- ptr + 1
    }

    input <- paste ("#", input, sep = "")            # Add leading '#'

    cat (substr (input, 1, 100), "\n", sep = "")     # Print at most 100 chars
}
