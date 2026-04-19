#!/opt/homebrew/bin/gsed


s/[^[:space:][:alpha:]]+//g  # Remove any non-letter, non-space character
s/^\s+//                     # Remove leading white space
s/\s+$//                     # Remove trailing white space
s/(.*)/\L\1/                 # Lower case entire string
s/\s+([[:alpha:]])/\u\1/g    # Upper case any letter following a space;
                             # delete the space
s/^/#/                       # Add leading '#'
s/(.{1,100}).*/\1/           # Keep at most 100 characters
