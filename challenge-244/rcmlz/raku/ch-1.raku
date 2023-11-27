unit module rcmlz::raku::task-one:ver<0.0.1>:auth<github:rcmlz>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr244/rcmlz/raku/ -- test/challenge-nr244/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr244 -- test/benchmark-scalability.raku --task=task-one --user=rcmlz --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr244; cat /tmp/nr244_task-one.csv

#|[
You are given an array of integers.
- Write a script to calculate the number of integers smaller than the integer at each index.

O(n log(n))
]
our sub solution(@input) is export {
	my @output[@input.elems];

	my @sorted = @input.sort(:k);
	my %new-old = @sorted.pairs;
	my %old-new = @sorted.antipairs;

	# we avoid O(n^2) solution by using double mapping of sorted ids of input array
	for @input.kv -> $k,$v {
		my $pos = %old-new{$k};
		while $pos > 0 && @input[%new-old{$pos - 1}] == $v {
			$pos--;
		}
		@output[$k] = $pos;

	}
	return @output;
}