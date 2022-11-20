#!/usr/bin/env perl6

say &cute-list(2); #2

sub cute-list (Int $n) {
    my @list=(1 .. $n);
    my $ctr=0;
    for (@list.permutations) -> @i {
        for (1 .. @i.elems) -> $j {
            ((@i[$j-1] %% $j) || ($j %% @i[$j-1])) || last;
            ($j==$n) && ($ctr++);
        }   
    }
    $ctr;
}

