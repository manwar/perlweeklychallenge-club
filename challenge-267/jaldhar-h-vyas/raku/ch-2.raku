#!/usr/bin/raku

sub MAIN(
    $str,
    *@widths
) {
    my @letters = $str.comb;
    my %widthmap = @letters.sort.unique.map({ $_ => @widths[$_.ord - 'a'.ord] });
    my $freespace = 100;
    my $lines = 1;

    for @letters -> $letter {
        if $freespace < %widthmap{$letter} {
            $lines++;
            $freespace = 100;
        }

        $freespace -= %widthmap{$letter};
    }

    say "($lines, {100 - $freespace})";
}