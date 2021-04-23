#!/usr/bin/env perl
# Perl weekly challenge 106
# Task 2: Decimal String
#
# See https://wlmb.github.io/2021/03/29/PWC106/#task-2-decimal-string
use strict;
use warnings;
use v5.12;
use integer;
use List::Util qw(all);
use POSIX qw(floor);

my ($numerator, $denominator)= @ARGV;
die "Usage: ./ch-2.pl numerator denominator"
    unless defined $numerator and defined $denominator;
# I assume positive integer numbers.
my $integer=$numerator/$denominator;
my $rest=$numerator%$denominator;
my %seen;
my $start=0;
my @digits;
while($rest && !defined $seen{$rest}){
    $seen{$rest}=$start++;
    push @digits, (10*$rest)/$denominator;
    $rest=(10*$rest)%$denominator;
}
$seen{0}=$start;
my $result=join '', "$integer.", @digits[0..$seen{$rest}-1];
$result.=join '', '(', @digits[$seen{$rest}..$#digits], ')' if $rest!=0;
say "$numerator/$denominator=$result";
