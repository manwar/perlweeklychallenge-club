#!/bin/env raku

wrapper('perlweeklychallenge', <weekly challenge perl>);
wrapper('perlandraku', <python ruby haskell>);

sub wrapper(Str:D $S, @W) {
    my @w = @W.sort({ $^a.chars < $^b.chars });
    my @res;

    my Bool $found-match = False;
    split-into($S, @w, @res);
    say 'no match' unless $found-match;

    sub split-into(Str:D $S, @W, @R) {
        if $S eq '' {
            say @R;
            $found-match = True;
            return;
        }

        for @W -> Str $word {
            next unless $S.starts-with($word);

            split-into($S.subst(/^$word/), @W, @R.push($word));
        }
    }
}
