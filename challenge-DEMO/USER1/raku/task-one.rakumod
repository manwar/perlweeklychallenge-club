unit module challenge-DEMO::USER1::raku::task-one:ver<0.0.1>:auth<USER1@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-DEMO/USER1/raku/ test/challenge-DEMO/raku/task-one.rakutest

#|[
Task Description goes here ...
]
our sub solution(@input) is export {
	@input.map( *.comb ).flat;
}