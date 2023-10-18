unit module two-colours::raku::task-one:ver<0.0.1>:auth<two-colours@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/two-colours/raku/ -- test/challenge-nr233/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalability.raku --task=task-one --user=two-colours --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
#our sub solution( List:D[Alpha:D] $words --> List:D[APair:D] ) is export {
our sub solution(@input) is export {
	@input>>.comb>>.Set.Bag.values.map({ $^n * ($^n - 1) div 2 }).sum;
}