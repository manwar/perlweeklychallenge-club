#!/opt/homebrew/bin/gawk

@load "ordchr"

#
# Loop over each line of input
#
{
    input = $0
    input = gensub (/^\s+/,             "",  1,  input) # Remove leading spaces
    input = gensub (/[^ \t[:alpha:]]+/, "", "g", input) # Remove non-letters,
                                                        # but keep spaces & tabs
    input = gensub (/\s+$/,             "",  1,  input) # Remove trailing spaces
    input = tolower (input)                             # Lower case all
    for (i = ord("a"); i <= ord("z"); i ++) {           # Upper case each letter
        input = gensub ("\\s+" chr(i),                  # following space; 
                         chr(i - 32), "g", input)       # delete that space
    }
    input = "#" input                                   # Add leading #
    print substr (input, 0, 100)                        # Print first 100 chars
}
