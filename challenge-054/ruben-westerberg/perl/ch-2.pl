#!/usr/bin/env perl
use strict;
use warnings;
use feature qw<say switch>;
no warnings qw<experimental recursion>;

my $max=$ARGV[0]//23; 		#sane default without cmd line args
my @seqs=( ([]) x 20);		#Initalise the largest 20 sequences found

for ( 1..$max) {
	my $s=collaz([int($_)]);
	for my $i (0..@seqs-1) {
		if (@$s  > @{$seqs[$i]}) {
			pop @seqs unless @seqs < 20;
			splice @seqs,$i,0,$s;
			last;
		}
	}
};

say "Top 20 Collaz Sequence lengths for starting numbers 1..$max";
for(grep { @$_ != 0} @seqs) {
	printf "Starting Number: %10d Sequence Length: %d\n", $_->[0],scalar @$_;
}



sub collaz {
	my ($seq)=@_;
	given ($seq->[-1]) {
		when ($_%2 == 0) {
			push @$seq, $_/2;
		}
		default {
			push @$seq, 3*$_+1;
		}
	}
	&collaz unless $seq->[-1]==1;
	$seq;	
}
