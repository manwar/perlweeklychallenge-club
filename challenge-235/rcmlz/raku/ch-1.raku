unit module rcmlz::raku::task-one:ver<0.0.1>:auth<rcmlz@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr235/rcmlz/raku/ -- test/challenge-nr235/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr235 -- test/benchmark-scalabiity.raku --task=task-one --user=rcmlz --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr235; cat /tmp/nr235_task-one.csv

my $REPLACEMENTS = 1;

#|[
You are given an array of integers.

- Write a script to find out if removing ONLY one integer makes it strictly increasing order.
]
our proto solution(@input, $replacements=$REPLACEMENTS) is export {*}

multi solution(@input where @input.unique.elems < @input.elems - 1, $replacements=$REPLACEMENTS){ False }

multi solution(@input where @input.elems < 2, $replacements=$REPLACEMENTS){ True }

multi solution(@input where @input.elems == 2, $replacements=$REPLACEMENTS){ 
	$replacements || @input[0] < @input[1] ?? True !! False
}

multi solution(@input, $replacements=$REPLACEMENTS) {
	for 1..^@input.elems -> $i {

		if @input[$i - 1] >= @input[$i] {

			return False if $replacements < 1;
			
			my @part1 = @input.clone;
			my @part2 = @input.clone;
				
			@part1.splice($i,1);
			@part2.splice($i - 1,1);

			return samewith(@part1, $replacements - 1) || samewith(@part2, $replacements - 1);			
		}
	}
	return True
}