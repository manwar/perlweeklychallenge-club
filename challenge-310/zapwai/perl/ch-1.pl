use v5.38;
sub proc(@list) {
    print "Input: ";
    print "(@$_) " for (@list);
    my @common;
    my @first = @{$list[0]};
    my $cnt = 0;
    for my $item (@first) {
	$cnt = 0;	
	for my $i (1 .. $#list) {
	    $cnt++ if ($item ~~ @{$list[$i]});
	}
	push @common, $item if ($cnt == $#list);
    }    
    say "\nOutput: @common";
}
my @list = ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] );
proc(@list);
@list = ( [1, 0, 2, 3], [2, 4, 5] );
proc(@list);
@list = ( [1, 2, 3], [4, 5], [6] );
proc(@list);
