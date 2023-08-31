unit module challenge-DEMO::USER2::raku::task-two:ver<0.0.1>:auth<USER2@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-DEMO/USER2/raku/ test/challenge-DEMO/raku/task-two.rakutest

#|[
Task Description goes here ...
]
our sub solution(@input) is export {
	@input.map( *.comb ).flat;
}