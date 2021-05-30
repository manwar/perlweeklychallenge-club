#!/usr/bin/perl
# The Weekly Challenge 114
# Task 1 Next Palindrome Number
# Usage: ch-1.pl [positive integer]
use strict;
use warnings;

my $integer = $ARGV[0] || 123454320;
die "Please input a decimal positive integer.\n"
    unless $integer =~ /^[1-9][0-9]*$/;

print higher_pal($integer), "\n";



sub higher_pal {
    my $n = $_[0];
    if ($n == (10**length $n) - 1 ) {
        return (10**length $n)+1;
    }

    my $suff = substr($n, 0, ((length $n) + 1)/2);
    my $p = pal_from_half( $suff, (length $n) % 2 );
    if ($n >= $p) {
        return pal_from_half( $suff+1, (length $n) % 2 );
    } 
    else {
        return $p;
    }
}

sub pal_from_half {
    my $s = $_[0];
    my $suf = substr( $s  , 0 , (length $s) - $_[1] );
    my $mid = $_[1] ? substr($s, -1, 1) : "";
    my $new = join "", $suf, $mid, reverse (split //, $suf);
    return $new;
}

=pod TEST DATA:
my %data_ret = 
   (103 => 111,
    999 => 1001,
    9999 => 10001,
    123 => 131,
    121 => 131,
    1048576 => 1049401,
    1234 => 1331,
   );
...

test case parameter 103: passed 
test case parameter 123: passed 
test case parameter 1234: passed 
test case parameter 9999: passed 
test case parameter 121: passed 
test case parameter 999: passed 
test case parameter 1048576: passed 

done 7 test case(s); PASS: 7 case(s) .
=cut
