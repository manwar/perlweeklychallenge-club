#!/opt/homebrew/bin/gawk

function tcmp (t1, t2) {
    if (t1 [1] < t2 [1]) {return -1}
    if (t1 [1] > t2 [1]) {return  1}
    if (t1 [2] < t2 [2]) {return -1}
    if (t1 [2] > t2 [2]) {return  1}
    return 0
}

#
# Loop over each line of input
#
{
    split ($1, b1, /:/)
    split ($2, e1, /:/)
    split ($3, b2, /:/)
    split ($4, e2, /:/)

    #
    # If both are straddling midnight, the times intersect
    #
    straddle1 = tcmp(b1, e1) > 0 ? 1 : 0
    straddle2 = tcmp(b2, e2) > 0 ? 1 : 0

    #
    # If both are straddling midnight, the times intersect
    #
    if (straddle1 && straddle2) {
        print "true"
        next
    }

    #
    # If one straddles midnight, add 24 hours to each time earlier
    # than the start time of one straddling midnight
    #
    if (straddle1) {
        if (tcmp(e1, b1) < 0) {e1 [1] += 24}
        if (tcmp(b2, b1) < 0) {b2 [1] += 24}
        if (tcmp(e2, b1) < 0) {e2 [1] += 24}
    }

    if (straddle2) {
        if (tcmp(e2, b2) < 0) {e2 [1] += 24}
        if (tcmp(b1, b2) < 0) {b1 [1] += 24}
        if (tcmp(e1, b2) < 0) {e1 [1] += 24}
    }

    #
    # Times will intersect, unless either
    #  - The second period finished before the first starts
    #  - The second period starts   after  the first end
    #      
    if (tcmp(e2, b1) <= 0 || tcmp(b2, e1) >= 0) {
        print "false"
    }
    else {
        print "true"
    }
}
