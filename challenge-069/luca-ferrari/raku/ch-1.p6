#!raku

sub MAIN( Int $A where { 1 <= $A <= 10**15 }
          , Int $B where { $A <= $B <= 10**15 } ) {
    say "Working from $A to $B";

    my %reverse = 0 => 0
    , 1 => 1
    , 6 => 9
    , 8 => 8
    , 9 => 6;

    my @found;

    for $A .. $B {
        # special case: single number
        @found.push( $_ ) && next if $_.chars == 1 && $_ == any( 0, 1, 8 );

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

        @found.push: $_ if $ok;
    }



    @found.join( ', ' ).say;
}
