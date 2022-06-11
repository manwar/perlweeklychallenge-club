use v6;
constant MAX = 5;

sub is-cardano-triplet (\a, \b, \c) {
    return False if a - b * c.sqrt > 0;
    my $val = ((a + b * c.sqrt) ** (1/3)) - ((- a + b * c.sqrt) ** (1/3));
    return $val =~= 1
}

my @values = 1..100;
my $count = 0;
OUT: for @values -> $i {
    for @values -> $j {
        for @values -> $k {
            if is-cardano-triplet $i, $j, $k {
                say "$i $j $k";
                $count++;
                last OUT if $count >= MAX;
            }
        }
    }
}
say "Duration: ", now - INIT now;
