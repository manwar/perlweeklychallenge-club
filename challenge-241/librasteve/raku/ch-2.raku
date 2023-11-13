use Data::Dump::Tree;
use Test;


my @tests = [
    %(
        int => (11, 8, 27, 4),
    ),
];

sub run( \int ) {

    sub prime-factors(Int $n is copy) {
        my $f = 2;

        gather {
            while $n > 1 {
                if $n %% $f {
                    $n div= $f; take $f
                } else {
                    $f++
                }
            }
        }
    }

    sub pf-count($n) { +prime-factors($n) }

    int.sort: *.&pf-count

}

say .<int>, " => ", run(.<int>) for @tests
