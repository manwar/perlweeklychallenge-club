#!/usr/bin/env raku 

sub MAIN(Str $S, UInt $C, UInt $O) {
    Usage() if $C < 1 or $O < 1 or $O < $C or $S.chars < $C + $O;

    my $N = $S.chars;

    my @S = $S.comb;

    map { @S[$_ % $N, ($_ + $O) % $N] = @S[($_ + $O) % $N, $_ % $N] }, 1 .. $C;

    say @S.join;
}

sub Usage {
    note "Usage: $*PROGRAM-NAME " ~ '$S $C $O';

    note 'where $C >= 1, $O >= 1, $O >= $C, $S.chars >= $C + $O';

    exit;
}
