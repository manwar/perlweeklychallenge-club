#!/usr/bin/raku

sub MAIN(
    Int $number #= an integer
) {

    my @truth = <abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
    my @segments = (
        < - a a a a a a a >,
        < - F - - - - - B >,
        < - F - - - - - B >,
        < - g g g g g g g >,
        < - E - - - - - C >,
        < - E - - - - - C >,
        < - d d d d d d d >,
    );

    my @template = $number.comb.map({ @truth[$_] });
    my $offset = 0;
    my @result = [ q{ } xx $number.chars * 8 ] xx 7;

    for @template -> $digit {
        for $digit.comb -> $segment {
            for 0 .. 6 -> $row {
                for 0 .. 7 -> $column {
                    if @segments[$row][$column].lc eq $segment {
                        @result[$row][$offset + $column] =
                            (@segments[$row][$column] ~~ 'A' .. 'Z') ?? q{|} !! q{-};
                    }
                }
            }
        }
        $offset += 8;
    }

    for 0 .. 6 -> $i {
        say @result[$i].join(q{});
    }
}