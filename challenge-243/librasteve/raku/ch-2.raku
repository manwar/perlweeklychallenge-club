use Data::Dump::Tree;
use Test;

my @tests = [
    %(
        nums => (2, 5, 9),
    ),
    %(
        nums => (7, 7, 7, 7, 7, 7, 7)
    ),
];

sub run( @nums ) {
    (@nums X, @nums).map( {(.[0] div .[1])}).sum
}

say run(.<nums>) for @tests;
