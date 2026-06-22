#!/opt/homebrew/bin/gawk


#
# Loop over each line of input
#
{
    split ($0, chars, "")
    rev = ""
    for (i = length (chars); i > 0; i --) {
        rev = rev chars [i]
    }
    print rev
}
