use Data::Dump::Tree;
use Math::Matrix :MM;
use Test;


my @tests = [
    %(
        matrix => ([1, 1, 0], [0, 1, 1], [0, 0, 1]),
    ),
    %(
        matrix => ([1, 1, 0], [1, 0, 1], [0, 0, 0]),
    ),
    %(
        matrix => ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]),
    ),
];

sub run( @matrix ) {
    my @nm = @matrix.map(*.reverse.map(+*.not)); 
    MM @nm
}

say run(.<matrix>) for @tests
