use strict;
use warnings;
use Test::More tests => 2;

sub sort_language {
    my ( $langs, $popularity ) = @_;
    return [
        map  { $_->[0] }
        sort { $a->[1] <=> $b->[1] }
        map  { [ $langs->[$_], $popularity->[$_] ] } 0 .. $#$langs
    ];
}

# Test Cases
is_deeply( sort_language( [ 'perl', 'c', 'python' ], [ 2, 1, 3 ] ), [ 'c', 'perl', 'python' ], 'Example 1' );
is_deeply(
    sort_language( [ 'c++', 'haskell', 'java' ], [ 1, 3, 2 ] ),
    [ 'c++', 'java', 'haskell' ],
    'Example 2'
);
