#!/opt/homebrew/bin/gawk

@load "ordchr"

#
# Loop over each line of input
#
{
    delete letters
    split ($0, letters, " ")
    for (i in letters) {
        if (letters [i] == "?") {
            qi = i
        }
        letters [i] = ord(letters [i])
    }
    base = letters [qi <= 3 ? qi + 1 :                    qi - 1]
    from = letters [qi <  3 ? qi + 3 : qi == 3 ? qi - 1 : qi - 3]
    to   = letters [qi <  3 ? qi + 2 :                    qi - 2]
    print chr(base - from + to)
}
