#!/usr/bin/env perl
# Perl weekly challenge 188
# Task 2:  Total Zero
#
# See https://wlmb.github.io/2022/10/25/PWC188/#task-2-total-zero
use v5.36;
use POSIX qw(floor);
die <<EOF unless @ARGV==2;
Usage: $0 x y
To count operations required to bring x or y to zero by succesive subtraction.
EOF
my ($counter, $actual)=(0, 0);
my ($x, $y)=my($x0, $y0)=@ARGV;
die "Only positive integers allowed" unless $x>0 and $y>0 and $x==floor $x and $y==floor $y;
use integer;
while($y>0){
    my ($d, $r)=($x/$y, $x%$y);
    $counter += $d;
    ++$actual;
    ($x, $y)=($y, $r);
}
say "The number of operations required to bring $x0 $y0 to zero is $counter (divisions: $actual)";
