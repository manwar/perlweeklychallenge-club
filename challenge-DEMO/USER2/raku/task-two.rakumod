unit module USER2::raku::task-two:ver<0.0.1>:auth<USER2@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-DEMO/USER2/raku/ -- test/challenge-DEMO/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-DEMO -- test/benchmark-scalabiity.raku --task=task-two --user=USER2 --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp DEMO; cat /tmp/DEMO_task-one.csv

#|[
Task Description goes here ...
]
our sub solution(@input) is export {
	@input.map( *.comb ).flat;
}