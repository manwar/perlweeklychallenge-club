use v5.36;
##
# You are given a list of integers, @list.
# Write a script to remove all zeroes, if any exist, to the end while
# maintaining the relative order of the non-zero elements.
##
sub move_zeroes{
    my @list = @_;
    my @zeroes;
    my @non_zeroes;
    {
        my $x = shift @list; 
        push @list, $x; 
        push @zeroes, $x if $x == 0;
	push @non_zeroes, $x if $x != 0;
        redo unless @zeroes + @non_zeroes == @list;
    }
    return (@non_zeroes, @zeroes);
}

MAIN:{
    say join(q/, /, move_zeroes(1, 0, 3, 0, 0, 5));    
    say join(q/, /, move_zeroes(1, 6, 4));    
    say join(q/, /, move_zeroes(0, 1, 0, 2, 0));    
}
