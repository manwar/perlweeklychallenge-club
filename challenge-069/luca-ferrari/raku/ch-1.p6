#!raku





sub MAIN( Int $A where { 1 <= $A <= 10**15 } = 1
          , Int $B where { $A <= $B <= 10**15 } = 10**15 ) {
    say "Working from $A to $B";

    my %reverse = 0 => 0
    , 1 => 1
    , 6 => 9
    , 8 => 8
    , 9 => 6;


    my @found = gather {
        for $A .. $B {
            # special case: single number
            take $_  if $_.chars == 1 && $_ == any( 0, 1, 8 );

            my @digits = $_.split: '', :skip-empty;

            # special case: if the number of digits is odd
            # the central digit must be a self reversing one
            next if ! @digits.elems %% 2
            &&  @digits[ ( @digits.elems / 2 ).Int ] != any ( 0, 1 , 8 );

            my $ok = True;
            CHECKING:
            for 0 ..^ @digits.elems -> $index {
                my ( $left, $right ) = $index, @digits.elems - $index - 1;
                last if $left == $right || $left > $right;
                $ok = False if ( %reverse{ @digits[ $left ] }:!exists )
                || ( %reverse{ @digits[ $right ] }:!exists );

                last CHECKING if ! $ok;
                $ok &= %reverse{ @digits[ $left ] } == @digits[ $right ];
                last CHECKING if ! $ok;
            }

            take $_ if $ok;
        }
    } # end of gather


    @found.unique.join( ', ' ).say;

}
