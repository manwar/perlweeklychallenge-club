#!/usr/bin/raku

sub MAIN(
    $int
) {
    my $root = $int;
    my $persistence = 0;

     while $root.chars > 1 {
        $root = $root.comb.sum;
        $persistence++;
    }

    say "Persistence  = $persistence\nDigital Root = $root";
}
