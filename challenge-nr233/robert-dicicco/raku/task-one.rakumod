unit module robert-dicicco::raku::task-one:ver<0.0.1>:auth<robert-dicicco@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/robert-dicicco/raku/ -- test/challenge-nr233/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-one --user=robert-dicicco --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@words) is export {
	my $pairs = 0;
	my $cnt = 1;

	for @words.combinations(2) {             # for each combination of size 2
	    my @arr = split(" ",$_);
	    my $srt1 = @arr[0].comb.unique.sort.join;
	    my $srt2 = @arr[1].comb.unique.sort.join;
	    if $srt1 eq $srt2 {
	        $pairs++;
	        $cnt++;
	    }
	}
	$pairs
}