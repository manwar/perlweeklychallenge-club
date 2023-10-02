use strict;
use warnings;
use Test::More;

sub max_gap {
    my @list = @_;
    return 0 if @list < 2;
    @list = sort { $a <=> $b } @list;
    my $max_gap = 0;
    for my $i ( 0 .. $#list - 1 ) {
        my $gap = $list[ $i + 1 ] - $list[$i];
        $max_gap = $gap if $gap > $max_gap;
    }
    return scalar grep { $list[ $_ + 1 ] - $list[$_] == $max_gap } ( 0 .. $#list - 1 );
}

# Test cases
is( max_gap( 2, 5, 8, 1 ), 2, 'Test Case 1' );
is( max_gap(3),            0, 'Test Case 2' );

done_testing();
