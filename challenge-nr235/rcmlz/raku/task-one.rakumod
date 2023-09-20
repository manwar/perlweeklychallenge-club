unit module rcmlz::raku::task-one:ver<0.0.1>:auth<rcmlz@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr235/rcmlz/raku/ -- test/challenge-nr235/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr235 -- test/benchmark-scalabiity.raku --task=task-one --user=rcmlz --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr235; cat /tmp/nr235_task-one.csv

#|[
You are given an array of integers.

- Write a script to find out if removing ONLY one integer makes it strictly increasing order.
]
our sub solution(@_) is export {
	(^+@_).map({[<] @_[|(^$_), |($_+1 ..^ +@_)]}).any.so
	#deletions(@input) > 1 ?? False !! True
}

multi deletions(@input where @input.elems < 2){0}

multi deletions(@input where @input.elems == 2){ 
	return (@input[0] >= @input[1]).Int 
}

multi deletions(@input where @input.elems == 3){
	my $del = 1;
	if @input[0] < @input[1] < @input[2] {
		$del = 0
	}elsif @input[2] <= @input[1] <= @input[0] {
		$del = 2
	}
	return $del	
}

multi deletions(@input where @input.unique.elems < @input.elems - 1){ 2 }

multi deletions(@input){
	samewith(@input[0..*-2]) + samewith(@input[*-3,*-2,*-1])
}