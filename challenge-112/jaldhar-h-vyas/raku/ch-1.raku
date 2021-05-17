#!/usr/bin/raku

sub MAIN(Str $p) {

    my $path = $p.subst(/ \/+ /, q{/}, :g).subst(/ \/ $ /, q{});

    my @dirs = $path.split(q{/});

    for 0 ..^ @dirs.elems -> $i {
        if @dirs[$i] eq q{..} {
            my $j = $i - 1;
            while $j != 0 && @dirs[$j] eq q{} {
                $j--;
            }
            @dirs[$j] = q{};
            @dirs[$i] = q{.};
        }

        if @dirs[$i] eq q{.} {
            @dirs[$i] = q{};
        }
    }

    say q{/}, @dirs.grep({ $_}).join(q{/});
}