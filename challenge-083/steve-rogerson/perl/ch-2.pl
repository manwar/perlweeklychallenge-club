#!/usr/bin/env perl 
use strict;
use warnings;
use utf8;
use 5.028;
use Scalar::Util 'looks_like_number';
use List::Util qw{sum};
use List::MoreUtils qw{pairwise};
#
# We get a list of positive numbers from the command line and "do the flip"
#
# I tried to think of nifty algorithm and failed, so going for brute force.
# One observation though is that if we change every sign, then the sign
# of the total will change, we only need 2^(N-1) values, look for
# the lowest non-zero absolute value and flip all signs if it's less than 0.
#

my @NUMBERS = @ARGV;

if ( @NUMBERS == 0 or grep { !looks_like_number($_) || $_ < 0 } @NUMBERS ) {
    die "Was expecting a list of positive numbers";
}

my $nums = int @NUMBERS;
if ( int $nums == 1 ) {
    say $NUMBERS[0];
}
my $smallest = sum(@NUMBERS);
my @best_bits=  (1) x @NUMBERS;
for my $i ( 0 .. 2**( $nums - 1 ) ) {
    my $pattern = sprintf("%0${nums}b", $i); # get pattern of 0s and 1s.
    my @bits= split //, $pattern; # split into array
    # 2*$a-1 turns 0 or 1 into -1 and 1 respectively.
    # then bring out the heavy guns..
    my $sum =sum ( pairwise { (2*$a -1) * $b} @bits, @NUMBERS);
    # We don't care about sign here.
    if (abs($sum) != 0 and abs($sum) < abs($smallest)) {
        @best_bits = @bits; # Remember the best so far.
        $smallest = $sum;
    }
}
# is the smallest is < 0 we need to flip all signs.
my $flip = ($smallest>0)*2-1;

my @flipped_numbers = pairwise { $flip * (2*$a -1) * $b} @best_bits, @NUMBERS;
say "@flipped_numbers";
say $flip * $smallest;
