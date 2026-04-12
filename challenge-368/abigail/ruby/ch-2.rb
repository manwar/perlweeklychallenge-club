#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    #
    # Parse input: split on white space, and make them integers
    #
    parts  = line . rstrip . split (" ")
    number = parts [0] . to_i
    mode   = parts [1] . to_i

    diff_factors = 0
    factors      = 0

    #
    # Try dividing by all odd numbers -- but use 2 if the number is 1.
    # Count different and total factors.
    #
    # Note that this way, we will never divide by a composite number --
    # if we encounter a composite number, we have already tried its factors.
    #
    d = 1
    while d * d <= number   # No C-style for loop in Ruby
        n = d == 1 ? 2 : d
        if number % n == 0
            diff_factors += 1
            while number % n == 0
                factors += 1
                number  /= n
            end
        end
        d += 2
    end

    #
    # At this point, number is either 1 or a large prime, not encountered
    # before. In the later case, add one of the number of factors and unique
    # factors.
    #
    if number != 1
        diff_factors += 1
        factors      += 1
    end

    puts mode == 1 ? factors : diff_factors
}
