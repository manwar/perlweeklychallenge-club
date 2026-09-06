#!/usr/bin/raku

sub MAIN(
    *@nums
) {
    my $current = 1;
    my $longest = $current;
    my $direction = Same;

    for 1 .. @nums.end -> $i {
        my $difference = @nums[$i] <=> @nums[$i - 1];

        if $difference == Same {
            $current = 1;
            $direction = Same;
        } elsif $difference == -$direction {
            $current++;
            $direction = $difference;
        } else {
            $current = 2;
            $direction = $difference;
        }

        if $current > $longest {
            $longest = $current;
        }
    }

    say $longest;
}
