unit module USER1::raku::task-one:ver<0.0.1>:auth<USER1@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-DEMO/USER1/raku/ -- test/challenge-DEMO/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-DEMO -- test/benchmark-scalabiity.raku --task=task-one --user=USER1 --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp DEMO; cat /tmp/DEMO_task-one.csv

#|[
Task Description goes here ...
]
our sub solution(@input) is export {
	@input.map( *.comb ).flat;
}