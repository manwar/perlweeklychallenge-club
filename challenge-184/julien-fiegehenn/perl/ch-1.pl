#!perl
use strict;
use warnings;

sub replace {
    my $i = 0;
    return map s/^../sprintf('%02d',$i++)/er, @_;
}

use Test::More;

is_deeply(
    [ replace( 'ab1234', 'cd5678', 'ef1342' ) ],
    [ '001234', '015678', '021342' ], 'first example'
);
is_deeply(
    [ replace( 'pq1122', 'rs3334' ) ], [ '001122', '013334' ],
    'second example'
);

done_testing;