#!/usr/bin/env raku

use v6.d;

# Second attempt at this using a different plan
#| Given a list of integers return all the wave sorted lists
multi sub MAIN( *@input where { $_.elems >= 2 && $_.all ~~ Int } ) {
    .say for find-waves( [], @input ).race.map( { $_.join(",") } );
}

# Start state
multi sub find-waves( [], @input is copy ) {
    gather {
        for @input.kv -> $i, $val {
            my @poss = @input[0..^$i,$i^..*-1].flat;
            take $_ for find-waves( [$val], @poss, 'gte' ).grep( { defined $_ } );
        }
    }
}

# End state
multi sub find-waves( @i, [] where { True }, 'gte' ) { ( @i, ); }
multi sub find-waves( @i, [] where { True }, 'lte' ) { ( @i, ); }

# Fail States
multi sub find-waves( @i, @p where { @i[*-1] < all(@p) }, 'gte' ) {}
multi sub find-waves( @i, @p where { @i[*-1] > all(@p) }, 'lte' ) {}

# Possible State
multi sub find-waves( @output is copy, @input is copy, $test ) {
    gather {
        my &test = $test ~~ 'gte' ?? &infix:«>=» !! &infix:«<=»;

        for @input.kv -> $i, $val {
            next unless &test( @output[*-1], $val );
            my @poss = @input[0..^$i,$i^..*-1].flat;

            take $_ for find-waves( [|@output, $val], @poss, $test ~~ 'gte' ?? 'lte' !! 'gte' ).grep( { defined $_ } );
        }
    }
}
