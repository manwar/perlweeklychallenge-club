# The Weekly Challenge 134
# Task 1 Middle 3-digits
# Usage: ch-1.pl [integer]
use v5.12.0;
use warnings;
use Test::More tests => 7;

my $n = $ARGV[0] || 1;

die "Not an integer. / Format ill-suited.\n" 
    unless $n =~ m/^[+-]?[1-9]+[\d]*$/ or $n =~ m/^[+-]?0$/;

say mid_three($n) if defined($ARGV[0]);



sub mid_three {

    my @arr = split //, abs($_[0]);

    return "even number of digits" if $#arr % 2 == 1;

    return "too short" if $#arr < 2;

    my $m = $#arr / 2;

    return $arr[$m-1].$arr[$m].$arr[$m+1];
}



ok mid_three(1234567) eq "345", "Example 1";
ok mid_three(-123) eq "123", "Example 2";
ok mid_three(1) eq "too short", "Example 3";
ok mid_three(10) eq "even number of digits", "Example 4";
ok mid_three(14285) eq "428", "TC 1";
ok mid_three(33_554_432) eq "even number of digits", "TC 2";
ok mid_three(1073_741_8240) eq "741", "TC 3";
