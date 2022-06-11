#!/usr/bin/env perl
# Perl weekly challenge 153
# Task 1: Left factorials
#
# See https://wlmb.github.io/2022/02/21/PWC153/#task-1-left-factorials
use v5.12;
use warnings;
use Memoize;
use bigint;
use Text::Wrap qw(wrap $columns $break);

memoize qw(left_factorial factorial);
die "Usage: ./ch-1.pl N\nto get the first N left factorials" unless @ARGV;
my $N=shift;
$columns=62; $break=qr/\s/;
say wrap("", "    ", "The first $N left factorials are: ",
    join ", ", map {left_factorial($_)} (0..$N-1));
sub left_factorial{
    my $n=shift;
    return factorial(0) if $n<=0;
    return factorial($n)+left_factorial($n-1);
}
sub factorial{
    my $k=shift;
    return 1 if $k<=0;
    return $k*factorial($k-1);
}
