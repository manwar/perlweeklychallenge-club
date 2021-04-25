#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

{
    SIZE = 7;
    #
    # Put the fields into an array.
    #
    for (i = 1; i <= SIZE; i ++) {
        numbers [i] = $i
    }

    #
    # Find all the differences between pairs of numbers
    #
    delete diffs
    delete diff_count
    for (i = 1; i <= SIZE; i ++) {
        for (j = i + 1; j <= SIZE; j ++) {
            diff = numbers [i] - numbers [j]
            diff_count [ diff] ++
            diff_count [-diff] ++
            l1 = diff_count [ diff]
            l2 = diff_count [-diff]
            diffs [ diff, l1, 1] = i
            diffs [ diff, l1, 2] = j
            diffs [-diff, l2, 1] = j
            diffs [-diff, l2, 2] = i
        }
    }

    #
    # Iterate over the numbers, and see if there is a number
    # which is equal to at least two differences.
    #
    # These numbers will be possibilities for d (at index d_i)
    #
    for (d_i = 1; d_i <= SIZE; d_i ++) {
        d = numbers [d_i]
        c = diff_count [d]
        if (diff_count [d] >= 2) {
            #
            # Find two pairs whose difference is d, where none
            # of the five numbers is reused.
            #
            for (i = 1; i <= c; i ++) {
                if (diffs [d, i, 1] != d_i && diffs [d, i, 2] != d_i) {
                    for (j = i + 1; j <= c; j ++) {
                        if (diffs [d, j, 1] != d_i &&
                            diffs [d, j, 2] != d_i &&
                            diffs [d, i, 1] != diffs [d, j, 1] &&
                            diffs [d, i, 1] != diffs [d, j, 2] &&
                            diffs [d, i, 2] != diffs [d, j, 1] &&
                            diffs [d, i, 2] != diffs [d, j, 2]) {
                            #
                            # W.l.o.g we can now assume diffs [d, i]
                            # contains the indices for a and c,
                            # and diffs [d, j] the indices for g and e.
                            #
                            a_i = diffs [d, i, 1]
                            c_i = diffs [d, i, 2]
                            g_i = diffs [d, j, 1]
                            e_i = diffs [d, j, 2]

                            #
                            # Find the unused positions for b and f
                            #
                            for (b_i = 1; b_i <= SIZE; b_i ++) {
                                if (b_i != a_i && b_i != c_i && b_i != d_i &&
                                    b_i != e_i && b_i != g_i) {
                                    for (f_i = 1; f_i <= SIZE; f_i ++) {
                                        if (f_i != a_i && f_i != b_i &&
                                            f_i != c_i && f_i != d_i &&
                                            f_i != e_i && f_i != g_i) {
                                            #
                                            # Do we have a winner?
                                            #
                                            target = numbers [a_i] + \
                                                     numbers [b_i]
                                            if (target == numbers [b_i] + \
                                                          numbers [c_i] +  \
                                                          numbers [d_i] &&
                                                target == numbers [d_i] + \
                                                          numbers [e_i] + \
                                                          numbers [f_i] &&
                                                target == numbers [f_i] + \
                                                          numbers [g_i]) {
                                                #
                                                # We have a winner. Print
                                                # it, and the reverse
                                                #
                                                printf "%d %d %d %d %d %d %d\n",
                                                       numbers [a_i],
                                                       numbers [b_i],
                                                       numbers [c_i],
                                                       numbers [d_i],
                                                       numbers [e_i],
                                                       numbers [f_i],
                                                       numbers [g_i]
                                                printf "%d %d %d %d %d %d %d\n",
                                                       numbers [g_i],
                                                       numbers [f_i],
                                                       numbers [e_i],
                                                       numbers [d_i],
                                                       numbers [c_i],
                                                       numbers [b_i],
                                                       numbers [a_i]
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
