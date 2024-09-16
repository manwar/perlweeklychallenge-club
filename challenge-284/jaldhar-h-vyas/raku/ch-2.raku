#!/usr/bin/raku

sub MAIN(
    Str $l1,
    Str $l2
) {
    my @list1 = $l1.words;
    my @list2 = $l2.words;
    my %elems = @list1.classify({ $_ });
    my @result;

    for @list2 -> $e {
        @result.push(| %elems{$e});
        %elems{$e}:delete;
    }

    for %elems.keys.sort -> $e {
        @result.push(| %elems{$e});
        %elems{$e}:delete;
    }

    say q{(}, @result.join(q{, }), q{)};
}