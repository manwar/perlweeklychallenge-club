#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |input|
    input .  sub!  /^\s+/,            ""   # Remove leading white space
    input . gsub!  /[^\s\p{L}]+/,     ""   # Remove non-letters, but keep space
    input .  sub!  /\s+$/,            ""   # Remove trailing white space
    input . downcase!                      # Lower case entire string
    input . gsub! (/\s+\p{L}/) {           # Upper case each letter following
                   |m| m [-1] . upcase}    # white space; drop white space
    input .  sub!  /^/,               "#"  # Leading '#'

    puts input [0, 100]                    # Print at most 100 characters
}
