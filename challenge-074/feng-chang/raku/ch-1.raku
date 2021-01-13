#!/bin/env raku

sub me(Int:D @a) {
    my %cnts;
    @a.map:{ ++%cnts{ $_ } };

    my Bool $got-one = False;
    for %cnts.keys -> $k {
        if %cnts{ $k } > @a.elems / 2 {
            say $k;
            $got-one = True;
            last;
        }
    }
    say -1 unless $got-one; 
}

me(my Int @ = 1, 2, 2, 3, 2, 4, 2);
me(my Int @ = 1, 3, 1, 2, 4, 5);
