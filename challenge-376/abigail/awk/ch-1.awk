#!/opt/homebrew/bin/gawk

@load "ordchr"

#
# Loop over each line of input
#
/^[a-h][1-8] [a-h][1-8]$/ {
    split ($0, chars, "")
    print (((ord(chars [1]) % 2 == ord(chars [2]) % 2) ? 1 : 0) +     \
           ((ord(chars [4]) % 2 == ord(chars [5]) % 2) ? 1 : 0)) == 1 \
           ? "false" : "true";
}
