#!/usr/bin/raku

sub wildcardPlayoffs(@results) {
    my @winners = (2, 7, 3, 6, 4, 5);
    my @week2 = (1);

    for 0 ..2 -> $i {
        @week2.push(@winners[2 * $i + ((@results[$i] eq 'H') ?? 0 !! 1)]);
    }

    return @week2.sort;
}

sub divisionalPlayoffs(@week2, @results) {
    my @winners = (0, 3, 1, 2);
    my @week3;

    for 0 .. 1 -> $i {
        @week3.push(@week2[@winners[2 * $i + ((@results[$i] eq 'H') ?? 0 !! 1)]]);
    }

    return @week3.sort;
}

sub conferenceFinals(@week3, $result) {
    return $result eq 'H' ?? (@week3[0], @week3[1]) !! (@week3[1], @week3[0]);
}

sub MAIN(
    $result where { $result.match(/^ <[AH]> ** 6 $/) } #= a string of 6 A or H characters
) {
    my @results = $result.comb;

    my @week2 = wildcardPlayoffs(@results[0..2]);

    my @week3 = divisionalPlayoffs(@week2, @results[3 .. 4]);

    my ($winner, $loser) = conferenceFinals(@week3, @results[5]);

    say "Team $winner defeated Team $loser"
}
