#!/usr/bin/env perl
# Perl weekly challenge 235
# Task 1:  Remove One
#
# See https://wlmb.github.io/2023/09/18/PWC235/#task-1-remove-one
use v5.36;

sub test(@in) {
    # Removing one element from a one or two element array yields an
    # empty or a one element trivially sorted array
    return 1 if @in<=2;
    my $count=0;
    my @sorted;
    push @sorted, shift @in;        # initialize
    while(@in){
	if($in[0]>$sorted[-1]){     # can move from @in to @sorted
			            # without disordering it?
	    push @sorted, shift @in;
	}else{                      # if not
	    $sorted[-1]=shift(@in); # replace last element of @sorted
	    ++$count;

	    return 0
		if $count>=2        # fail if too many replacements or
                                    # if @sorted is not actually ordered
		|| (@sorted>=2 && $sorted[-2] >= $sorted[-1]);
	}
    }return 1;                      # success
}
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 {N2...]
    to find if the array N1, N2... becomes sorted by removing
    only one element.
    FIN
my @in=@ARGV;
my $out=test(@in)?"True":"False";
say "@ARGV -> $out";
