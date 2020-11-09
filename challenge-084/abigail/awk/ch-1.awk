#
# You are given an integer $N.
#
# Write a script to reverse the given integer and print the result.
# Print 0 if the result doesn't fit in 32-bit signed integer.
# 
# The number 2,147,483,647 is the maximum positive value for a 32-bit
# signed binary integer in computing.
# 

#
# This is two challenges in one. First, we have to reverse a given
# integer -- which in AWK we do character by character.
#
# For the second part, we have to compare it against a given
# maximum value. Awk, or at least my version, handles big integers
# just fine.
#
# There's a tiny thing to consider. 2,147,483,647 is the largest
# positive value which fits in a 32-bit signed integer, but the
# smallest integer which fits is -2,147,483,648 [1]. So, if the input
# is 8463847412, the output should 0, but if the input is -8463847412,
# the output should be -2147483648.
#
# [1] We're assuming 2s-complement integers, which seems to have
#     been the norm for the past 50 years or so.
#

{
    low     = 0;     # Indicates lower bound for reversing
    reverse = "";    # This will contain the reversed number.

    #
    # Check whether the number starts with a hyphen; if so, 
    # keep the sign, and don't include it in the part which
    # needs reversing.
    #
    if (substr ($0, 1, 1) == "-") {
        reverse = "-";
        low     = 1;
    }

    #
    # Do the actual reversal. Note that in AWK strings are 1-based,
    # and, hence, length() gives the highest index.
    #
    for (i = length ($0); i > low; i --) {
        reverse = reverse substr ($0, i, 1);
    }
    #
    # Turn reverse into a number
    #
    reverse = reverse + 0;

    #
    # Check wether it fits in a 32-bit integer (we assume 2's complement)
    #
    if (reverse < -2147483648 || reverse > 2147483647) {
        reverse = 0;
    }
    print reverse;
}
