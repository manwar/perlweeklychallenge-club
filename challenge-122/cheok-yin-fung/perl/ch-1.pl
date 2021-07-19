#!/usr/bin/perl
# The Weekly Challenge - 122
# Task 1 Average of Stream
use strict;
use warnings;
use v5.10.0;
say "Keep entering a number and the average of the stream will be printed."; 
my $num = <STDIN>; 
my $numeric = qr/^[+-]?\d+.?\d*$/;
exit if $num !~ /$numeric/;
my $n = 1;
my $sum = $num;
printf "Average of the first number is %.3f\n", $num;
$num = <STDIN>;
while ($num =~ m/$numeric/ ){
    $sum += $num;
    $n++;
    printf "Average of the first $n numbers is %.3f\n", $sum/$n;
    $num = <STDIN>; 
}

