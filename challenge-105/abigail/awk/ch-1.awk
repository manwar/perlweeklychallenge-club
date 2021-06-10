#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#
# Input will consist of lines; each line will have two numbers, N and k, N > 0,
# k > 0. For each line of input, we output a line with the Nth root of k.
#
# We're not doing any input validations; we're assuming it's correct.
#

#
# To find the Nth root of a number k, we just raise k to the power 1/N
#

{
    printf "%.10f\n", $2 ^ (1 / $1)
}
