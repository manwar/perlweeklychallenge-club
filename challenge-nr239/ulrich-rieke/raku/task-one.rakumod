unit module ulrich-rieke::raku::task-one:ver<0.0.1>:auth<github:ulrich-rieke>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr239/ulrich-rieke/raku/ -- test/challenge-nr239/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr239 -- test/benchmark-scalability.raku --task=task-one --user=ulrich-rieke --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr239; cat /tmp/nr239_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
	my $firstLine = @input[0];
	my $secondLine =  @input[1];
	$firstLine.subst-mutate( /\s+/ , '' , :g) ;
	$secondLine.subst-mutate( /\s+/ , '' , :g) ;
	$firstLine eq $secondLine
}