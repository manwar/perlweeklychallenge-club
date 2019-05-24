use v6;

for grep { is-prime $_ }, 0..300 -> $prime {
    my $mersenne =  2 ** $prime - 1;
    say $mersenne * 2 ** ($prime - 1) if is-prime $mersenne;
}
say "time taken ", now - INIT now;
