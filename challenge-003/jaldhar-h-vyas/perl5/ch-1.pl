#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub usage {
    print <<"-USAGE-";
    Usage:
    $0 <number>

<number>    maximum integer to search for 5-smooth numbers
-USAGE-

    exit(1);
}

sub isSmooth {
    my ($num) = @_;

    # get the divisors that _aren't_ multiples of 2, 3, or 5
    my @divisors = grep { ($_ % 2 != 0) && ($_ % 3 != 0) && ($_% 5 != 0) }
                   (grep { $num % $_ == 0 } (1 .. $num));

    # 1 is always a divisor so the array will always have atleast one member.
    return scalar @divisors == 1;
}


if (scalar @ARGV < 1) {
   usage();
}

say join q{ }, grep { isSmooth($_) } (1 .. $ARGV[0]);
