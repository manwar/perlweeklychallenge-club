my @squares = map { $_² }, grep {.is-prime}, 2..250.sqrt.Int;
# say @squares; # [4 9 25 49 121 169] squares of prime integers
NEXT_I: for 1..500 -> $i {
    for @squares -> $j {
        next NEXT_I if $i %% $j;
        last if $j > $i;
    }
    print "$i ";
}
say "\nDuration: ", now - INIT now;
