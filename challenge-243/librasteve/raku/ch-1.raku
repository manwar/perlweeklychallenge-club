use Data::Dump::Tree;
use Test;

my @tests = [
    %(
        nums => (1, 3, 2, 3, 1),
    ),
    %(
        nums => (2, 4, 3, 5, 1)
    ),
];

sub run( @nums ) {
    @nums.combinations(2).grep({ .[0] > (2 * .[1]) }).elems
}

say run(.<nums>) for @tests;
