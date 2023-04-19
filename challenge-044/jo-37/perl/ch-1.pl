#!/usr/bin/perl -s

use v5.16;
use warnings;
use Math::Prime::Util qw(forcomp todigits vecsum vecprod lastfor);
use List::MoreUtils qw(zip6 zip);
use experimental 'signatures';

our ($digits, $sum, $help);
$digits //= '123456789';
$sum //= 100;

die <<EOS if $help;
usage: $0 [-digits=DIGITS] [-sum=SUM] [-help]

-digits=DIGITS
    digit string to be split into parts. Default: '123456789'
 
-sum=SUM
    sum to be produced from adding/substracting parts of DIGITS. Default: 100

-help
    this help text

EOS

### Input and Output

say for combine_to($digits, $sum);


### Implementation

# Generalizing the task to arbitrary digit strings and sums.

sub combine_to ($digits, $sum) {
    my $len = length $digits;
    my @out;
    # Iterate over integer compositions.
	forcomp {
        # Split the digits into parts according to the current
        # composition.
        my @parts = $digits =~ /^@{[join('', map "(.{$_})", @_)]}$/;
        # Loop over the signs for all but the first part (having a fixed
        # sign of +1), represented by a number with the first bit of one
        # in its binary representation.
        for my $sb (2 ** (@_ - 1) .. 2 ** @_ - 1) {
            # Convert number to signs.
            my @signs = map $_ ? 1 : -1, todigits $sb, 2, @_;
            # Multiply all parts with their sign and sum.  Report a
            # match.
            if (vecsum(map vecprod(@$_), zip6 @parts, @signs) == $sum) {
                # Convert 1/-1 to +/- removing the first.
                my @ops = (map(chr(44 - $_), @signs[1..$#signs]), '');
                push @out, "@{[zip @parts, @ops]}= $sum";
            }
        }
    } $len, {amax => $len - 1};
    @out;
}
