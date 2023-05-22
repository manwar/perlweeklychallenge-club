sub task1 ( @m ) { @m[*;*].sort.[2] }

sub task1_alternate ( @m ) {
    my @top;
    @top.append( .sort.head(3) ) for @m;
    return @top.sort.head(3).tail;
}


my @tests =
    ( 1, ( (3, 1, 2), (5, 2, 4), (0, 1, 3) ) ),
    ( 4, ( (2, 1   ), (4, 5   )            ) ),
    ( 0, ( (1, 0, 3), (0, 0, 0), (1, 2, 1) ) ),

    # Alpha translations of the numeric tests above,
    # because the generic sort supports it!
    ( 'B', ( <D  B  C>, <F  C  E>, <A  B  D> ) ),
    ( 'E', ( <C  B   >, <E  F   >            ) ),
    ( 'A', ( <B  A  D>, <A  A  A>, <B  C  B> ) ),
;
use Test;
plan +@tests;
for @tests -> ( $expected, @in ) {
    is task1(@in), $expected;
}

{
    my @ones = (1 xx 1000) xx 1000;
    my ( $task1_time, $task1_alternate_time );
    for ^10 {
        {
            my $t = now;
            task1(@ones) == 1 or die for ^10;
            $task1_time += now - $t;
        }
        {
            my $t = now;
            task1_alternate(@ones) == 1 or die for ^10;
            $task1_alternate_time += now - $t;
        }
    }
    say (:$task1_time, :$task1_alternate_time, x => $task1_time/$task1_alternate_time );
}
