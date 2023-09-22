unit module {{USER}}::raku::task-one:ver<0.0.1>:auth<github:{{USER}}>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-{{CHALLENGE}}/{{USER}}/raku/ -- test/challenge-{{CHALLENGE}}/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-{{CHALLENGE}} -- test/benchmark-scalabiity.raku --task=task-one --user={{USER}} --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp {{CHALLENGE}}; cat /tmp/{{CHALLENGE}}_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
#our sub solution( List:D[Alpha:D] $words --> List:D[APair:D] ) is export {
	@input.map( *.comb ).flat;
}