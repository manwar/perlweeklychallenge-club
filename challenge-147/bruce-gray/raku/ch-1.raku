# "Left-truncatable prime" is not fully defined by the task; are leading zeros valid?
# e.g. 103 -> 03 -> 3 ; all are prime, but is `03` considered a "number"?
# OEIS has separate pages for each definition:
#   http://oeis.org/A033664 2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97, 103, 107, 113, ...
#   http://oeis.org/A024785 2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97,           113, ...
# Since one definition is more easily written as a filter,
# and the other definition is best written as a generator, I have both below.


sub is-left-truncatable-prime ( UInt \N --> Bool ) {
    return (0 ..^ N.chars)          # Starting positions of substrings
        .map(  { N.substr($_) })    # All left-truncated substrings
        .first({ .is-prime.not })   # Find the first non-prime
        .defined.not;               # If no non-prime found, then True
}
constant @LTP_A033664 = grep &is-left-truncatable-prime, ^Inf;


my @LTP_A024785 = lazy gather loop {
    state @current_gen = grep &is-prime, ^10;
    .take for @current_gen;
    @current_gen = grep &is-prime, ((1..9) X~ @current_gen);
}


put @LTP_A033664.head(20);
put @LTP_A024785.head(20);
