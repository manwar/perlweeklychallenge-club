#!/usr/bin/raku

sub MAIN(
    *@nums
) {
    my @sorted = @nums.sort({ $^a <=> $^b });
    my $difference = (@sorted[1] - @sorted[0]).abs;
    my $isArithmeticProgression = True;

    for 2 .. @sorted.end -> $i {
        if @sorted[$i] - @sorted[$i - 1] != $difference {
            $isArithmeticProgression = False;
            last;
        }
    }

    say $isArithmeticProgression;
}