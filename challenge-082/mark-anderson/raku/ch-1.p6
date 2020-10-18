unit sub MAIN(UInt $M, UInt $N);

my $gcd = ($M gcd $N);

say (1..$gcd).grep($gcd %% *).join(", ").List;
