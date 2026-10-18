#!/usr/bin/raku

sub MAIN(
    *@words
) {
    my $size = @words[0].chars;
    my @grid;
    my %used;

    sub search(Str $prefix) {
        if @grid.elems == $size {
            return True;
        }

        for @words.grep({ $_.starts-with($prefix) }) -> $word {
            if %used{$word}:exists {
                next;
            }

            @grid.push($word);
            %used{$word} = True;

            my $column = @grid.elems;
            my $nextPrefix = @grid.map({ $_.substr($column, 1) }).join;

            if search($nextPrefix) {
                return True;
            }

            @grid.pop;
            %used{$word}:delete;
        }

        return False;
    }

    search(q{});

    say q{(}, @grid.map({ "\"$_\"" }).join(q{, }), q{)};
}
