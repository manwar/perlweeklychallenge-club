# For a full explanation of this logic, see my text and code in "Single-pass_solution" at:
#   http://rosettacode.org/wiki/Equilibrium_index#Raku

sub eq_index ( @list --> Array ) {
    my $sum = 0;

    my %h = @list.pairs.classify: :as{.key}, {
        $sum += .value;
        $sum * 2 - .value;
    };

    return %h{$sum} // [];
}

my @tests =
    (  1,  3,  5,  7,  9         ) => (  3,                         ),
    (  1,  2,  3,  4,  5         ) => (                             ), # No Equilibrium Index exists
    (  2,  4,  2,                ) => (  1,                         ),
    ( -7,  1,  5,  2, -4,  3,  0 ) => (  3,  6,                     ),
    (  2,  4,  6,                ) => (                             ), # No Equilibrium Index exists
    (  2,  9,  2,                ) => (  1,                         ),
    (  1, -1,  1, -1,  1, -1,  1 ) => (  0,  1,  2,  3,  4,  5,  6, ),
;
use Test;
plan +@tests;
for @tests -> ( :key(@in), :value(@expected) ) {
    my @got = eq_index(@in);
    is @got, @expected, "eq_index(@in[]) == @expected[]";
}
