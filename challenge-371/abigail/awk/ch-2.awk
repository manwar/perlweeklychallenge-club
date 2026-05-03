#!/opt/homebrew/bin/gawk


#
# Loop over each line of input
#
{
    #
    # Try every number 1 .. 2^NF -1 as a mask. NF is the number of fields,
    # so the number of elements in the input set. NF is the number of fields,
    #
    for (mask = 1; mask < 2 ** NF - 1; mask ++) {
        sum = 0
        delete set
        for (idx = 1; idx <= NF; idx ++) {
            #
            # If the position of the number is in the mask,
            # add the difference of the number and the 
            # position to the sum, and add the number to the (sub)set
            #
            if (and (mask, lshift (1, (idx - 1)))) {
                sum += $idx - idx
                set [length (set) + 1] = $idx
            }
        }
        if (sum == 0 && length (set) > 1) {
            #
            # We now have a subset (with more than one element) whose sum
            # equals the sum of the positions. So, we print it.
            #
            for (i = 1; i <= length (set); i ++) {
                printf "%d%s", set [i], i == length (set) ? "; " : " "
            }
        }
    }
    printf "\n"
}
