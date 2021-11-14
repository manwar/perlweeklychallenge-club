use v6;

sub multiplication-table (Int $m, Int $n) {
    my SetHash $distinct;
    say "x |", join " ", map {.fmt("%3d")}, 1..$n;
    for 1..$m -> $i {
        my @res = map { $i * $_ }, 1..$n;
        $distinct{$_} = True for @res;
        say "$i |", join " ", map {.fmt("%3d")}, @res;
    }
    say "Distinct terms: ", $distinct.keys.sort.join(" ");
    say "Count: ", $distinct.keys.elems;
}
multiplication-table(7, 5);
