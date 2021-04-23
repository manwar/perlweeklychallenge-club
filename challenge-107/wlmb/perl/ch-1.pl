#!/usr/bin/env perl
# Perl weekly challenge 107
# Task 1: Self-descriptive Numbers
# Use some properties to accelerate their generation
# Use letter to go beyond base 10
#
# See https://wlmb.github.io/2021/04/05/PWC107/#task-1-self-descriptive-numbers
use strict;
use warnings;
use v5.12;
use List::Util qw(all);

die 'Use: ./ch1.pl howmany' unless @ARGV;
my $howmany=shift @ARGV;
exit unless $howmany > 0;
my @results;
my $largest_base=36; #allows ten decimal digits and 26 letters
my @letter_from_digit=(0..9,'a'..'z');
my $base=1;
 RESULT:
    while($howmany>@results){
	++$base;
	last RESULT if $base>$largest_base;
	for my $firstdigit(1..$base-1){
	    my $have=[(0)x$base]; #initialize digits in number
	    $have->[$firstdigit]++;
	    try([$firstdigit],0,$base, $firstdigit, $have);
	    last RESULT if @results==$howmany;
	}
}
my $n=1;
foreach(@results){
    say sprintf("%2d- Base %2d:  %s", $n++, scalar @$_,
		join('', map {$letter_from_digit[$_]} @$_));
}
sub try {
    my ($current,$position,$base, $sum, $had)=@_;
    if($position==$base-1){
	push @results, $current if check($current);
	return;
    }
    ++$position;
    for my $digit($had->[$position]..$base-$sum){
	my $have=[@$had]; # copy
	$have->[$digit]++;
	try([(@$current,$digit)], $position, $base, $sum+$digit, $have);
    }
}

sub check {
    my $number=shift;
    my @digits=@$number;
    my @need=(0)x@digits;
    my @have=(0)x@digits;
    map {$need[$_]=$digits[$_]; $have[$digits[$_]]++} 0..@digits-1;
    return all {$need[$_]==$have[$_]} 0..@digits-1;
}
