use Data::Dump::Tree;
use Test;

my @tests = [
    %(
        arr1 => (1,2,3),
        arr2 => (2,4,6),
    ),
    %(
        arr1 => (1,2,3,3),
        arr2 => (1,1,2,2),
    ),
];

sub run( @arrs ) {

    sub missing( [@haystack, @needle] ) {
        [(@needle ∖ @haystack).keys] || |[Empty]        # Set difference
    }

    ($_, $_.reverse).map(*.&missing) given @arrs

}

say run([.<arr1>, .<arr2>]) for @tests;
