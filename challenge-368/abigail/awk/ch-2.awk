#!/opt/homebrew/bin/gawk


#
# Loop over each line of input
#
{
    number = $1
    mode   = $2

    diff_factors = 0
         factors = 0

    #
    # Try dividing by all odd numbers -- but use 2 if the number is 1.
    # Count different and total factors.
    #
    # Note that this way, we will never divide by a composite number --
    # if we encounter a composite number, we have already tried its factors.
    #
    for (d = 1; d * d <= number; d += 2) {
        n = d == 1 ? 2 : d
        if (number % n == 0) {
            diff_factors ++
            while (number % n == 0) {
                factors ++
                number /= n
            }
        }
    }

    #
    # At this point, number is either 1 or a large prime, not encountered
    # before. In the later case, add one of the number of factors and unique
    # factors.
    #
    if (number != 1) {
        diff_factors ++
        factors ++
    }

    print mode == 1 ? factors : diff_factors
}
