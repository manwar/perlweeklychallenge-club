#!/bin/env raku

unit sub MAIN(UInt:D \n where * > 0);

sub solve(@S is copy, @s is copy) {
    return 0 if +@S == 0;
    return 0 if +@S.any == 0;

    #return +@S[0] if +@S == 1;
    if +@S == 1 {
        put ' ', (|@s, |@S[0]).join(' ');
        return +@S[0];
    }

    my \n = @S[0].shift;
    my \cnt = solve(@S, @s);

    @S.shift;
    @S .= map({ $_.grep(!(* == n)).Array });
    @s.push(n);

    cnt + solve(@S, @s)
}

my @S = (1..n).map(-> \m { (1..n).grep({ m %% $_ or $_ %% m }).Array });
put "candidates: {@S.gist}";

put solve(@S, []);
