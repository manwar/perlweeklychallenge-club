# The Weekly Challenge 117
# Task 1 Missing Row
# Usage: awk -f 'ch-1.awk' < [text file]

BEGIN {
    max = 15
    separator = ","
    for (i = 1; i <= max; i++)
        arr[i] = "F"
}

{
    y = index($0, separator)
    x = substr($0, 1, y-1)
    arr[x] = "T"
}

END {
    for (i = 1; i <= max; i++)
        if (arr[i] == "F")
            print i
}
