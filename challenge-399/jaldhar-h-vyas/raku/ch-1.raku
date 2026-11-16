#!/usr/bin/raku

# It uses a sliding-window (two-pointer) algorithm. A frequency map tracks
# characters in the window; when the window would require more than k
# replacements, the left edge advances. It runs in O(n) time and uses O(d) space,
#  where d is the number of distinct characters.

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
