package main;
use strict;
use warnings;

sub replace_chars {
    my @input = @_;

    my @output;
    my $pos = 0;

    for my $item (@input) {

        # assuming to rotate the sequence if more than 100 words
        my $next_item = sprintf( "%.2d", $pos % 100 );

        push @output, $next_item . substr( $item, 2 );
        $pos++;

    }

    return \@output;
}

use Test::More;

is_deeply( replace_chars( ( 'ab1234', 'cd5678', 'ef1342' ) ),
    [ '001234', '015678', '021342' ] );
is_deeply( replace_chars( ( 'pq1122', 'rs3334' ) ), [ '001122', '013334' ] );

done_testing;
1;
