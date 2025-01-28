#!/usr/bin/env perl
# Perl weekly challenge 306
# Task 1:  Odd Sum
#
# See https://wlmb.github.io/2025/01/27/PWC306/#task-1-odd-sum
use v5.36;
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 A1 A2...
    to compute the sum of all odd contiguous subarrays of the arrays
    A1, A2.... The inputs A1 are strings of the form
    ¨[N1 N2...Nn]" to be interpreted as arrays by PDL.
    FIN
for(@ARGV){
    my $input = pdl($_);
    my $N = $input->dim(0);
    my $zeroes = zeroes($N, $N); # indexed by d,g
    my $d=$zeroes->xvals;             # number positions
    my $g=1+$zeroes->yvals;           # group sizes
    my $repetitions =
	pdl(
	    $d+1,
	    $N-$d,
	    $g,
	    $N+1-$g                           # bounds of number of repetitions
	)->mv(-1,0)->minover                  # number of repetitions for each term for each group size
	->mv(1,0)->slice([0,-1,2])            # restrict to odd group sizes
	->sumover;                            # actual number of repetitions for each term
    my $output = $repetitions->inner($input); # multiply and sum
    say "$input -> $output"
}
