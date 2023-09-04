unit module challenge-nr233::mark-anderson::raku::task-one:ver<0.0.1>:auth<mark-anderson@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/mark-anderson/raku/ test/challenge-nr233/raku/task-one.rakutest

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
	@input.combinations(2).grep({ [eqv] .map({ .comb.Set }) }).elems
}