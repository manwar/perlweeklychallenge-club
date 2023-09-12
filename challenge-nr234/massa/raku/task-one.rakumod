unit module massa::raku::task-one:ver<0.0.1>:auth<massa@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr234/massa/raku/ -- test/challenge-nr234/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr234 -- test/benchmark-scalabiity.raku --task=task-one --user=massa --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr234; cat /tmp/nr234_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
	 ([∩] @input».comb».Bag).kv.map({ $^a xx $^b }).flat
}