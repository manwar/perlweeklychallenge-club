# Test: perl6 ch1.p6
use v6.d;

my @numbers = (1, 2, 3, 4, 6);
my %rings = (
    blue   => 8, yellow => 7,
    green  => 5, red    => 9,
);

sub MAIN() {
    my @perms = @numbers.permutations;

    for @perms -> $perm {
        my %slots = (
            redgreen     => $perm[0],
            greenblack   => $perm[1],
            black        => $perm[2],
            blackyellow  => $perm[3],
            yellowblue   => $perm[4]
        );

        if (validate-answer(%rings, %slots)) {
            for (%slots.keys) -> $key {
                say 'Slot: ' ~ $key ~
                    ' value: ' ~ %slots.{$key};
            }
        }
    }
}


sub validate-answer(%r, %s) { # rings and slots

    return
    ( %s.<redgreen> + %r.<red> == 11 &&
      %s.<redgreen> + %r.<green> + %s.<greenblack> == 11 &&
      %s.<greenblack> + %s.<black> + %s.<blackyellow> == 11 &&
      %s.<blackyellow> + %r.<yellow> + %s.<yellowblue> == 11 &&
      %r.<blue> + %s.<yellowblue> == 11 );
}
