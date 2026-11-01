#!/usr/bin/raku

sub MAIN(
    *@arr
) {
    my %reflections;
    for @arr -> $e {
        %reflections{$e.base(2).flip.parse-base(2).Int}.push($e);
    }

    my @sorted;
    for %reflections.keys.sort({ $^a <=> $^b }) -> $k {
        @sorted.push(| %reflections{$k}.sort({ $^a <=> $^b }) );
    }

    say q{(}, @sorted.join(q{, }), q{)};
}
