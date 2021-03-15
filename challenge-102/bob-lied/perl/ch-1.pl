#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 102, Task #1, Rare Numbers
#
# You are given a positive integer $N.
# Write a script to generate all Rare numbers of size $N if exists.
# http://www.shyamsundergupta.com/rare.htm
# The web site lists several constraints that can be used to limit the search.
# Also discussed at https://rosettacode.org/wiki/Talk:Rare_numbers
# Examples
# (a) 2 digits: 65
# (b) 6 digits: 621770
# (c) 9 digits: 281089082
#
# From the reference web site:
# The numbers, which gives a perfect square on adding as well as subtracting
# its reverse are rare and hence termed as Rare Numbers.
# 
# If R is a positive integer and R1 is the integer obtained from R by writing
# its decimal digits in reverse order, then if R + R1 and R - R1 both are
# perfect square then R is termed as Rare Number.
# 
# So for R to be a Rare Number we must have
# R + R1 = X^2 and R - R1 = Y^2
# 
# For example: For R=65, R1=56
# R+R1 = 65+56 = 121 = 11^2   AND    R-R1 = 65 - 56 = 9 = 3^2
#
#=============================================================================

use strict;
use warnings;
use 5.020;

use experimental qw/ signatures /;

use Getopt::Long;

my $doTest = 0;
my $verbose = 0;
GetOptions("test" => \$doTest, "verbose" => \&verbose);

my $N = shift;

# On my MacBook M1, perl 5.32, 8 takes about 7 seconds and 9 takes about 1:15
# 10 is probably feasible, maybe 11 for the giftedly patient, but beyond that
# needs some kind of parallelism or an algorithm I wasn't able to think of.
die Usage() unless defined $N && $N > 1 && $N < 20;
warn "Expect this to take a long time ..." if $N > 8;

# The last digit can never be 1,4,6,9
my @mightBeRare   = ( 1, 0, 1, 1, 0, 1, 0, 1, 1, 0 );

# A perfect square can never end in 2,3,7,8
my @mightBeSquare = ( 1, 1, 0, 0, 1, 1, 1, 0, 0, 1 );

my $isNodd = $N % 2;    # Optimization possible for even or odd digits.

# Cache results of square root test here.
my %knownSquare;

# For example, if N = 3, max is 1000, but we want 100 at a time.
my $scale = 10**($N-1);

# Rare numbers can never start with an odd digit, so work on
# only groups that start with an even digit.
# Creates pairs of start and end.
my @boundary = map { [ $_ * 2 * $scale, $_ * 2 * $scale + $scale - 1 ] } 1..4;

# Use faster integer math everywhere except where we need the square root.
use integer;

for my $bound ( @boundary )
{
    my $endOfRange = $bound->[1];   # Hoist array access out of loop processing.
    R: for ( my $r = $bound->[0] ; $r <= $endOfRange ; $r++ )
    {
        # say "$r ", scalar(time()) if $r % 10000000 == 0; # Progress mark

        # The last digit can never be 1,4,6,9
        next unless $mightBeRare[ $r%10 ];

        my $r1;
        $r1 = reverse($r);   # String beats math
       ##{   use integer;
       ##    my $n = $r; $r1 = 0;
       ##    while ( $n )
       ##    {
       ##        $r1 = $r1 * 10 + $n%10;
       ##        $n /= 10;
       ##    }
       ##}

        my $y2 = $r - $r1;
        next if $y2 < 0;    # No imaginary numbers.
        next unless $mightBeSquare[ $y2 % 10];

        my $x2 = $r + $r1;
        next unless $mightBeSquare[ $x2 % 10];

        # If R consist of odd number of digits, then R-R1 must be divisible by 11.
        # Since R-R1 is always divisible by 9, So 1089 (33^2) must be a factor of Y2.
        # 
        # If R consist of even number of digits, then R+R1 must be divisible by 11,
        # So 121 must be a factor of X2.
        if ( $isNodd )
        {
            next if $y2 % 1089;
        }
        else
        {
            next if $x2 % 121;
        }

        # Save the expensive square root computation for last.

        # Caching wasn't effective.  Either the overhead of hash lookup was not
        # much better than the cost of the sqrt function, or there aren't many
        # cache hits.  And memory could blow up for large N.
      # if ( exists $knownSquare{$x2} )
      # {
      #     next unless $knownSquare{$x2};
      # }
      # else
      # {
      #     my $x = sqrt($x2);
      #     next unless ($knownSquare{$x2} = (int($x) == $x));
      # }

      # if ( exists $knownSquare{$y2} )
      # {
      #     next unless $knownSquare{$y2};
      # }
      # else
      # {
      #     my $y = sqrt($y2);
      #     next unless ($knownSquare{$y2} = (int($y) == $y));
      # }

        { no integer;
            my $x = sqrt($x2);
            next R unless int($x) == $x;
            my $y = sqrt($y2);
            next R unless int($y) == $y;
        }

        say "R: $r";
    }
}
