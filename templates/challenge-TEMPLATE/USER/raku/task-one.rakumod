unit module challenge-{{TEMPLATE}}::{{USER}}::raku::task-one:ver<0.0.1>:auth<{{USER}}@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-{{TEMPLATE}}/{{USER}}/raku/ test/challenge-{{TEMPLATE}}/raku/task-one.rakutest
# or               raku --optimize=3 test/benchmark-scalabiity.raku --task=task-one --user={{USER}} --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp {{TEMPLATE}}; cat /tmp/{{TEMPLATE}}_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
#our sub solution( List:D[Alpha:D] $words --> List:D[APair:D] ) is export {
our sub solution(@input) is export {
	@input.map( *.comb ).flat;
}