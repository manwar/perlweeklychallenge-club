#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my %nums = @ints.map({ $_ => True });
    my $longest = 0;

    for @ints -> $i {
        unless %nums{$i - 1} {
            my $current = $i;
            my $length = 1;

            while %nums{$current + 1} {
                $current++;
                $length++;
            }

            $longest = ($longest, $length).max;
        }
    }

    say $longest > 1 ?? $longest !! -1;
}
