#!/opt/homebrew/bin/gawk


#
# Loop over each line of input
#
{
    gsub (/"/, "")                                # Remove quotes
    spaces  = gsub (/ /, " ")                     # Count spaces
    gaps    = NF - 1                              # Nr of gaps between words
    per_gap = gaps ? int (spaces / gaps) : 0      # Calculate amount 
    end     = spaces - gaps * per_gap             #   of spaces needed
    printf "\""                                   # Print quote
    for (i = 1; i <= NF; i ++) {
        printf $i                                 # Print word
        for (j = 1; j <= (i == NF ? end : per_gap); j ++) {
            printf " "                            # Print gap, space by space
        }
    }
    print "\""                                    # Print quote
}
