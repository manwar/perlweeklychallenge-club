#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#


#
# Get rid of leading sign
#
/^[-+]/         {$0 = substr ($0, 2)}

#
# Validation
#
/[^0-9]/        {print "not an integer";        next}
/^(..)*$/       {print "even number of digits"; next}
length ($0) < 3 {print "too short";             next}

#
# Print the middle three digits
#

                {print substr ($0, 1 + (length ($0) - 3) / 2, 3)}
