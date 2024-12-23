#!/usr/bin/raku

sub longestSet(@ints) {
    my $maxLength = 0;

    for @ints.kv -> $i, $val {
        my %seen;
        my $current = $i;
        my $length = 0;

        while !%seen{$current} {
            %seen{$current} = True;
            $current = @ints[$current];
            $length++;
        }

        if $length > $maxLength {
            $maxLength = $length;
        }
    }

    return $maxLength;
}

sub MAIN(
    *@ints
) {
    say longestSet(@ints);
}