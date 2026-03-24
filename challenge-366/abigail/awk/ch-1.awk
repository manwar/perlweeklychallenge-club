#!/opt/homebrew/bin/gawk


#
# Loop over each line of input
#
{
    #
    # $1 is the word to check against. $2 .. $NF are the potential prefixes
    #
    matches = 0
    for (i = 2; i <= NF; i ++) {
        #
        # Remove any double quotes
        #
        gsub (/"+/, "", $i)
        if (1 == index ($1, $i)) {
            matches ++
        }
    }
    print matches
}
