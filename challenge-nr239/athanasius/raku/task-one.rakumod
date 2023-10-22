unit module athanasius::raku::task-one:ver<0.0.1>:auth<github:athanasius>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr239/athanasius/raku/ -- test/challenge-nr239/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr239 -- test/benchmark-scalability.raku --task=task-one --user=athanasius --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr239; cat /tmp/nr239_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
#our sub solution( List:D[Alpha:D] $words --> List:D[APair:D] ) is export {
	@input.map( *.comb ).flat;
}