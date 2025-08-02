#!/usr/bin/raku 

sub MAIN(
    Int $n
) {
    my @results = (1 .. $n div 2).map({ | ($_, -$_) });

    unless $n %% 2 {
        @results.push(0);
    }

    say q{(}, @results.sort.join(q{, }), q{)};
}