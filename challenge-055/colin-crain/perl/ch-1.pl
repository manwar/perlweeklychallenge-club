#! /opt/local/bin/perl
#
#       flipper_faster_than_lightning.pl
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
#                 • keep track of the tally, cross-referenced to the window endpoints
#                 • find and output the pairs that produce the largest value
#
#             To create the windows, we need two loops: one to establish the starting index,
#             the second to determine the width, which in turn can be used to determine the
#             ending index.
#
#             Within each inner loop, we construct a string of 0s the same
#             length as the binary input, with 1s placed in the window. This
#             will serve as a bitmask. We can flip any bit by XORing that bit
#             with 1 so converting the input and the bitmask to decimal and
#             applying xor, then stringifying back to base 2 will give us the
#             result we need.
#
#             There's a variety of ways we can count the ones after we first we
#             split the string into an array. Because the data, 1 is the same as
#             the incidence, we could for instance sum the digits, which would
#             increment the count 1 for every 1 and add nothing for the 0s.
#
#                     $sum += $_ for split //, $str;
#
#             is cute and effective. Or use List::Util::sum for the task. Or use
#             grep and a scalar context to directly count:
#
#                     $sum = grep /1/, split //, $str;
#
#             I can't decide who's prettier.
#
#             We need three related values to determine the output: the xor'd
#             binary string, the count of 1s in that string and the window
#             coordinates that created it. Two parallel hashes keyed on the
#             binary string serve here. We extract the maximum value of the
#             counted 1s and use this as a filter to make a list of those binary
#             strings that produce that value. Then we can iterate over that
#             list and lookup the window left and right indices that correspond
#             for output.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:


my $bin = shift @ARGV // '100110011';
my $len = length $bin;
my $num = oct('0b' . $bin);

say "$bin  binary input";

my %ones;
my %windows;

for my $start ( 0..$len-1) {
    for my $span ( 1..$len-$start) {
        ## make bitmask
        my $mask = ('0' x $start) . ('1' x $span) . ( '0' x ( $len - ($start + $span)));

        ## convert to decimal, xor with input number and back to binary
        my $xbin = sprintf "%0" . "$len" . "b", $num ^ oct('0b' . $mask);

        ## hash number of 1s keyed on xor result, hash window start, end indices keyed on xor result
        $ones{$xbin}    = count_ones( $xbin );
        $windows{$xbin} = [$start, $start+$span-1];
    }
}

my $maxval = (sort {$a<=>$b} values %ones)[-1];
my @max    = grep { $ones{$_} == $maxval } keys %ones;

say "$_  result for     L=$windows{$_}->[0], R=$windows{$_}->[1]" for sort {    $windows{$a}->[0] <=> $windows{$b}->[0]
                                                                                                   ||
                                                                                $windows{$a}->[1] <=> $windows{$b}->[1]   } @max;


## ## ## ## ## SUBS:

sub count_ones {
    my $str = shift;
    my $sum;
    $sum += $_ for split //, $str;
    return $sum;
}

