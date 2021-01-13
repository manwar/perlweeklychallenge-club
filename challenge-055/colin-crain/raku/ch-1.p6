use v6.d;

#
#       flipper.raku
#
#         55 - TASK #1
#         Flip Binary
#             You are given a binary number B, consisting of N binary digits 0
#             or 1: s0, s1, …, s(N-1).
#
#             Choose two indices L and R such that 0 ≤ L ≤ R < N and flip the
#             digits s(L), s(L+1), …, s(R). By flipping, we mean change 0 to 1
#             and vice-versa.
#
#             For example, given the binary number 010, the possible flip pair
#             results are listed below:
#
#                 L=0, R=0 the result binary: 110
#                 L=0, R=1 the result binary: 100
#                 L=0, R=2 the result binary: 101
#                 L=1, R=1 the result binary: 000
#                 L=1, R=2 the result binary: 001
#                 L=2, R=2 the result binary: 011
#
#             Write a script to find the indices (L,R) that results in a binary
#             number with maximum number of 1s. If you find more than one
#             maximal pair L,R then print all of them.
#
#             Continuing our example, note that we had three pairs (L=0, R=0),
#             (L=0, R=2), and (L=2, R=2) that resulted in a binary number with
#             two 1s, which was the maximum. So we would print all three pairs.
#
#         method: what a strange puzzle. That's it, had to get that out there.
#
#             In any case, the challenge is that given an array of 1s and 0s, we
#             construct windows to map on that array within which we toggle the
#             values, so that 1 -> 0 and 0 -> 1. After the transformation we
#             count the 1s for the whole array and produce the parameters of
#             those windows that maximise this value.
#
#             There are quite a few moving parts to this challenge. We need to:
#                 • construct the window endpoints
#                 • flip the bits within the endpoints
#                 • count the ones
#                 • keep track of the tally, cross-referenced to the window
#                   endpoints
#                 • find and output the pairs that produce the largest value
#
#             To create the windows, we need two loops: one to establish the
#             starting index, the second to determine the width, which in turn
#             can be used to determine the ending index.
#
#             Within each inner loop, we construct a string of 0s the same
#             length as the binary input, with 1s placed in the window. This
#             will serve as a bitmask. We can flip any bit by XORing that bit
#             with 1 so converting the input and the bitmask to decimal and
#             applying xor, then stringifying back to base 2 will give us the
#             result we need.
#
#             Counting the 1s can be swiftly dispatched in Raku by spitting the string
#             into characters with comb and summing the resulting array. Because
#             the item we are counting, 1s, have the same value as their
#             incidence, this works out nicely.

#             We need three related values to determine the output: the xor'd
#             binary string, the count of 1s in that string and the window
#             coordinates that created it. Two parallel hashes keyed on the
#             binary string serve here. We extract the maximum value of the
#             counted 1s and use this as a filter to make a list of those binary
#             strings that produce that value. Then we can iterate over that
#             list and lookup the window left and right indices that correspond
#             for output.

#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN ( Str:D $binary = '100110011' ) {

    say "$binary  binary input";

    my $chars = $binary.chars;
    my $num   = :2( $binary );
    my %ones;
    my %windows;

    for ( 0..$chars-1) -> $start {
        for ( 1..$chars-$start) -> $span {
            my $mskbin  = ('0' x $start) ~ ('1' x $span) ~ ( '0' x ( $chars - ($start + $span)));

            my $mask    = :2( $mskbin );                       ## convert binary mask string to decimal number
            my $xorbin  = ($num +^ $mask).base(2);             ## xor and convert to binary
            %ones{$xorbin}    = $xorbin.comb.sum;              ## hash summed digits keyed on xor result
            %windows{$xorbin} = [$start, $start+$span-1];      ## hash window parameters keyed on xor result
        }
    }

    my @max    = %ones.keys.grep( { %ones{$_} == %ones.values.max } );

    my $sort = sub { %windows{$^a}[0] <=> %windows{$^b}[0] || %windows{$^a}[1] <=> %windows{$^b}[1] }
    say "$_  result for     L=%windows{$_}[0], R=%windows{$_}[1]" for @max.sort( $sort );



}

