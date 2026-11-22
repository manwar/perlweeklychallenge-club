#!/usr/bin/raku

sub MAIN(
    $str,
    $k
) {
    my @chars = $str.comb;
    my %frequency;
    my $maxCount = 0;
    my $longestLength = 0;
    my $left = 0;

    for @chars.kv -> $right, $char {
        %frequency{$char}++;
        $maxCount = max($maxCount, %frequency{$char});

        while $right - $left + 1 - $maxCount > $k {
            my $leftChar = @chars[$left];
            %frequency{$leftChar}--;
            $left++;
        }

        $longestLength = max($longestLength, $right - $left + 1);
    }

    say $longestLength;
}
