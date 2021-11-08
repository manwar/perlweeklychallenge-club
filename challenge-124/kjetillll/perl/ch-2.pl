#!/usr/bin/env perl
use strict;
use warnings;

sub sum{my$s;map$s+=$_,@_;$s}

sub div{
    my %least;
    for my $div (0..2**@_-1){
	my @ss=([],[]);
	push( @{ $ss[$div%2] }, $_) and $div>>=1 for @_;
	next if @{$ss[0]} != @{$ss[1]} + @_%2;
	my $diff=abs( sum(@{$ss[0]}) - sum(@{$ss[1]}) );
	%least=(diff=>$diff,subsets=>\@ss)
	    if not exists $least{diff}
	    or $diff < $least{diff};
    }
    @{$least{subsets}}
}

#Run on input list given as command line args
#or two test cases if no input args is given.

my @cases = @ARGV ? ( [@ARGV] )
                  : ( [10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
		      [10, -15, 20, 30, -25, 0, 5, 40, -5] );
for ( @cases ) {
    print "-" x 50, "\n";
    print "Input:   @$_\n";
    print "Output sum ".sum(@$_).":   @$_\n" for div(@$_);
}
