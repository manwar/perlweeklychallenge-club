#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk
#

BEGIN {
    tokens   = 12
    max_take =  3

    while (tokens > 0) {
        printf "How many tokens do you take? (%2d token%s are left) ", \
                tokens, (tokens == 1 ? "" : "s");
        if ((getline take) > 0) {
            if (1 <= take && take <= max_take) {
                takes = max_take + 1 - take
                printf "Computer takes %d token%s\n", \
                        takes, (takes == 1 ? "" : "s")
                tokens -= (max_take + 1)
            }
        }
    }

    print "Computer wins"
}
