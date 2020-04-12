#!/usr/bin/env raku

my $max=@*ARGS[0]//23; 		#sane default without cmd line args
my @seqs=( [] xx 20);		#Initalise the largest 20 sequences found
my $l=Lock.new;			#Create a lock to allow sequential access to top 20

(1..$max).hyper(batch=>1000, degree=>8).map: {
	my $s=collaz([$_ ,]);
	$l.protect({
		for (0..^@seqs) -> $i {
			if $s.elems  > @seqs[$i].elems {
				@seqs.pop unless @seqs.elems < 20;
				@seqs.splice($i,0,[$s]);
				last;
			}
		}
	});
	();
};

say "Top 20 Collaz Sequence lengths for starting numbers 1..$max";
for @seqs.grep: *.elems != 0 {
	printf "Starting Number: %10d Sequence Length: %d\n", .[0],.elems;
}



sub collaz ($seq) {
	given $seq[*-1] {
		when $_%%2 {
			$seq.push: $_/2;
		}
		default {
			$seq.push: 3*$_+1;
		}
	}
	collaz($seq) unless $seq[*-1]==1;
	$seq;	
}
