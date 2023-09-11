unit module jaldhar-h-vyas::raku::task-one:ver<0.0.1>:auth<jaldhar-h-vyas@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/jaldhar-h-vyas/raku/ -- test/challenge-nr233/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-one --user=jaldhar-h-vyas --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
	@input.map({$_.comb.unique.sort.join}).combinations(2).grep({@$_[0]eq@$_[1]}).elems
}