#!/opt/homebrew/bin/gawk


#
# Loop over each line of input
#
{
    n = $1
    if (n >= NF) {    # Special case when n exceeds the list size
        print "-1;"
        next
    }
    per_set  = int ((NF - 1) / n)    # Elements per set
    overflow = NF - 1 - n * per_set  # Number of sets with an extra element
    ptr = 2                          # Start of list
    for (i = 1; i <= n; i ++) {
        set_size = per_set           # Calculate current set size
        if (i <= overflow) {
            set_size ++
        }
        for (j = 1; j <= set_size; j ++) {  # Print sets
            printf "%s%s", $ptr, j == set_size ? "; " : " "
            ptr ++
        }
    }
    printf "\n"
}
