#!/usr/bin/raku

sub MAIN(
    $str1,
    $str2,
    $str3
) {
    my @characters = $str1.comb;
    my %longest;
    my $longestLength = 0;

    for @characters.keys -> $start {
        my $previousCategory;

        for $start .. @characters.end -> $end {
            my $category = @characters[$end].lc ~~ /<[aeiou]>/
                ?? 'vowel'
                !! 'consonant';

            if $previousCategory.defined && $category eq $previousCategory {
                last;
            }
            $previousCategory = $category;

            my $candidate = @characters[$start .. $end].join;
            unless $str2.contains($candidate) && $str3.contains($candidate) {
                next;
            }

            my $length = $end - $start + 1;
            if $length > $longestLength {
                %longest = $candidate => True;
                $longestLength = $length;
            } elsif $length == $longestLength {
                %longest{$candidate} = True;
            }
        }
    }

    say q{(} ~ %longest.keys.sort.map({ "\"$_\"" }).join(q{, }) ~ q{)};
}
