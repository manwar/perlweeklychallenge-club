sub task2 ( @list ) {
    my ( @nums, @alphas );
    for @list {
        my %h = .words.classify({ ?/<alpha>/ });
        push @alphas, $_ with %h{True};
        push @nums  , $_ with %h{False};
    }
    return @nums, @alphas;
}


use Test;
my @tests =
    ( ( 'a 1 2 b 0', '3 c 4 d' ),
      ( [ ['1','2','0'], ['3','4'] ], [ ['a','b'], ['c','d'] ] ) ),

    ( ( '1 2', 'p q r', 's 3', '4 5 t' ),
      ( [ ['1','2'], ['3'], ['4','5'] ], [ [ 'p', 'q', 'r' ], ['s'], ['t'] ] ) ),
;

plan +@tests;
for @tests -> ( $in, $expected ) {
    is-deeply $expected, task2($in);
}
