unit module bruce-gray::raku::task-one:ver<0.0.1>:auth<bruce-gray@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/bruce-gray/raku/ -- test/challenge-nr233/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-one --user=bruce-gray --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
#our sub solution( List:D[Alpha:D] $words --> List:D[APair:D] ) is export {
our sub solution(@words) is export {
	return @words.classify( *.comb.Set )
	                 .values
	                 .map(      *.combinations(2).elems )
	                 .sum;
}