unit module arne-sommer::raku::task-one:ver<0.0.1>:auth<arne-sommer@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/arne-sommer/raku/ -- test/challenge-nr233/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-one --user=arne-sommer --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
	my @result;
	my @words = @input;

	while @words
	{
	  my $first           = @words.shift;
	  my $first-canonical = $first.comb.sort.unique.join;

	  for @words -> $second
	  {
	    my $second-canonical = $second.comb.sort.unique.join;
	    if $first-canonical eq $second-canonical
	    {
	      @result.push( ($first, $second) );
	    }
	  }
	}

    @result.elems;
}