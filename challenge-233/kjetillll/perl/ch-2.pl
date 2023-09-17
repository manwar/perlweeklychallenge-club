
@ARGV ? print join(',', frequency_sort( @ARGV ))."\n"
      : run_tests();

sub frequency_sort {
    my %freq;
    $freq{$_}++ for @_;              #count the input ints
    sort {                           #return sort of @_ by:
	$freq{$a} <=> $freq{$b}      #increasing frequency
	or                           #or
	$b <=> $a                    #decreasing int
    }
    @_;
}

sub run_tests {
    for(
	{
	    Input  => [1,1,2,2,2,3],
	    Output => [3,1,1,2,2,2]
	},
	{
	    Input  => [2,3,1,3,2],
	    Output => [1,3,3,2,2]
	},
	{
	    Input  => [-1,1,-6,4,5,-6,1,4,1],
	    Output => [5,-1,4,4,-6,-6,1,1,1]
	}
    ){
	my($input,$expected)=@$_{qw(Input Output)};
	my @got = frequency_sort( @$input );
	print "@got" eq "@$expected" ? 'ok' : '***ERROR', "\n";
    }
}
