#!/usr/bin/env perl
# Perl weekly challenge 356
# Task 1:  Kolakoski Sequence
#
# See https://wlmb.github.io/2026/01/12/PWC356/#task-1-kolakoski-sequence
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to find how many 1's there are in a Kolakoski sequence of length Ni
    FIN
my @map=(undef,2,1);                          # to map 1,2 to 2,1
my @sequence=(1,2,2);                         # initial sequence
my $current=1;                                # current repetition
for(@ARGV){
    try{
	die "Input shouldn't be negative" if $_<0;
	while(@sequence<$_){                      # until the sequence is large enough
	    my $digit=$map[$sequence[-1]];        # take last digit and map it 1,2 to 2,1
	    my $repetition=$sequence[++$current]; # how many repetitions of next digit
	    push @sequence,($digit)x$repetition;
	}
	my @replica=@sequence;                    # copy
	splice @replica, $_;                      # truncate the copy
	say "$_ -> ", 0+grep{$_==1} @replica;     # filter and count 1's, and output
    }
    catch($e){warn $e;}
}
