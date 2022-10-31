#!/usr/bin/env perl
package challenge189::ch1;

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use List::Util qw(reduce minstr);

use Test::More tests => 10;

is(    #
    greater_character_pretty( 'b', [ 'e', 'm', 'u', 'g' ] ),
    'e', 'Example 1 (pretty)'
);
is(    #
    greater_character_pretty( 'a', [ 'd', 'c', 'e', 'f' ] ),
    'c', 'Example 2 (pretty)'
);

is(    #
    greater_character_pretty( 'o', [ 'j', 'a', 'r' ] ),
    'r', 'Example 3 (pretty)'
);

is(    #
    greater_character_pretty( 'a', [ 'd', 'c', 'a', 'f' ] ),
    'c', 'Example 4 (pretty)'
);
is(    #
    greater_character_pretty( 'v', [ 't', 'g', 'a', 'l' ] ),
    'v', 'Example 5 (pretty)'
);
is(    #
    greater_character_reduce( 'b', [ 'e', 'm', 'u', 'g' ] ),
    'e', 'Example 1 (reduce)'
);
is(    #
    greater_character_reduce( 'a', [ 'd', 'c', 'e', 'f' ] ),
    'c', 'Example 2 (reduce)'
);
is(    #
    greater_character_reduce( 'o', [ 'j', 'a', 'r' ] ),
    'r', 'Example 3 (reduce)'
);
is(    #
    greater_character_reduce( 'a', [ 'd', 'c', 'a', 'f' ] ),
    'c', 'Example 4 (reduce)'
);
is(    #
    greater_character_reduce( 'v', [ 't', 'g', 'a', 'l' ] ),
    'v', 'Example 5 (reduce)'
);

sub greater_character_pretty ( $target, $array ) {
    minstr( grep { $_ gt $target } $array->@* ) // $target;
}

sub greater_character_reduce ( $target, $array ) {
    reduce(
        sub {
            if ( $b le $target || ( defined $a && $a lt $b ) ) {
                return $a;
            }

            return $b;
        },
        undef,
        $array->@*
    ) // $target;
}

