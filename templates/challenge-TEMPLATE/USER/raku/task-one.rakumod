unit module challenge-{{TEMPLATE}}::{{USER}}::raku::task-one:ver<0.0.1>:auth<{{USER}}@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-{{TEMPLATE}}/{{USER}}/raku/ test/challenge-{{TEMPLATE}}/raku/task-one.rakutest

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
	@input.map( *.comb ).flat;
}