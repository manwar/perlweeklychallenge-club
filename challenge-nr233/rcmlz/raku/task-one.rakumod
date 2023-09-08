unit module challenge-nr233::rcmlz::raku::task-one:ver<0.0.1>:auth<rcmlz@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/rcmlz/raku/ test/challenge-nr233/raku/task-one.rakutest
#                  raku --optimize=3 test/benchmark-scalabiity.raku --task=task-one --user=rcmlz --max-run-time=1 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-one.csv

#|[
You are given an array of words made up of alphabets only.

- Write a script to find the number of pairs of similar words. 
- Two words are similar if they consist of the same characters.
]
our proto solution(@input) is export { * }
multi solution(@input) { 0 }
multi solution(@input where *.elems > 1) {
	my $n = @input.elems;
	my $hits = 0;	

	my @char-sets = @input.map( *.comb.Set );

	for ^($n - 1) -> $i {
	    for ($i + 1)..^$n -> $j {
	    	  $hits++ if @char-sets[$i] ≡ @char-sets[$j];
		}
	}
	return $hits;
}