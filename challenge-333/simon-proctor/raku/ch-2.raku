#!/usr/bin/env raku

multi sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is double-zero(1, 0, 2, 3, 0, 4, 5, 0), (1, 0, 0, 2, 3, 0, 0, 4);
    is double-zero(1, 2, 3), (1, 2, 3);
    is double-zero(1, 2, 3, 0), (1, 2, 3, 0);
    is double-zero(0, 0, 1, 2), (0, 0, 0, 0);
    is double-zero(1, 2, 0, 3, 4), (1, 2, 0, 0, 3);
    done-testing;
}

#| Given a list of integers double any zeros and return a same length list
multi sub MAIN(
    *@args where all(@args) ~~ IntStr #= List of Integers
) {
    say double-zero( |@args.map(*.Int) ).join(",");
}

sub double-zero( *@args where all(@args) ~~ Int  ) {
    my $l = @args.elems;
    return @args.map( { $_ ~~ 0 ?? |(0,0) !! $_ } )[0..^$l].List;
}
