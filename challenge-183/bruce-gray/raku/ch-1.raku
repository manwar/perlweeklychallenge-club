sub unique-array ( @a ) {
    return @a.unique( with => &[eqv] );
}

my @tests =
    { Input    => ( [1,2], [3,4], [5,6], [1,2] ),
      Expected => ( [1,2], [3,4], [5,6]        ) },

    { Input    => ( [9,1], [3,7], [2,5], [2,5] ),
      Expected => ( [9,1], [3,7], [2,5]        ) },
;
use Test;
plan +@tests;
for @tests -> ( :Input(@in), :Expected(@exp) ) {
    is-deeply unique-array(@in), @exp;
}
