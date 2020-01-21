#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
  qw{ experimental::postderef experimental::smartmatch experimental::signatures };

use List::Util qw{ sum0 };
use Scalar::Util qw{ looks_like_number };
use JSON;
my $json = JSON->new;

my $instructions = <<'END';
    Write a script to generate Self-descriptive Numbers in a given base.

    In mathematics, a self-descriptive number is an integer m 
    that in a given base b is b digits long in which each digit d 
    at position n (the most significant digit being at position 0 
    and the least significant at position b - 1) counts how many 
    instances of digit n are in m.

    For example, if the given base is 10, then script should print 
    6210001000.
END

# the canonical steps are 

#   * make it work
#   * make it right
#   * make it fast

# and I have done the first two. 

# Given base 2, there are 4 possible strings to analyze
#   00 , which is 2 zeroes and 0 ones (20) and cannot be described in base-2
#   01 , which is 1 zero and 1 one, (11), which does not describe this number
#   10 , which is 1 zero and 1 one, (11), which does not describe this number
#   11 , which is 0 zeroes and 2 ones, (02) which cannot be described in base-2

# so, there's no self-describing base-2 number. 

# going deeper, 42101000 is a self-describing base-8 number, as it has
# 4 zeroes
# 2 ones
# 1 two
# 0 threes
# 1 four
# and 0 fives, sixes or sevens.

# additionally, since there are n digits in a base-n self-describing
# number, the sum of the digits should be n as well.

# NOTE: this program handles bases 2-10. Going above that involves adding
# letters for numbers, with A meaning decimal 10 in base-11 and higher.
# it'd be a small addition of complexity to convert A to 10 and vice
# versa, but that seems frustrating.

my $base = looks_like_number $ARGV[0] ? 0 + $ARGV[0] : 10;
$base = $base > 0 ? $base : 10;
exit if $base > 10;

my @bases = 0 .. 9;

my $min = 0 x $base;
my $max = ($base) x $base;

OUTER: for my $n ( $min .. $max ) {
    my @count;
    my @n = split //,$n;
    my $sum = sum0  @n;

    # first, we insure count is valid
    # then we drop out-of-range entries
    for my $d ( @n ) { next OUTER if $d >= $base }
    next OUTER if $sum != $base;
 
    map { @count[$_] = 0 } 0 .. $base - 1;
    for my $d ( 0 .. $base - 1 ) {
        $count[$d] = () = $n =~ /($d)/gmix;
        next OUTER if $count[$d] >= $base;
    }
    my $c = join '', @count;
    my $match =   $n == $c ? 1 : 0;
    say join "\t", '', $n, $c, $match if $match;
}

__DATA__
