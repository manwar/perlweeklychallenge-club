sub reverse-vowels(Str $s) returns Str {
    my @vowels = $s.comb(/<[aeiouAEIOU]>/).reverse;
    my $vowel-index = 0;

    # Replace vowels in the string with reversed vowels
    $s ~~ s:g/<[aeiouAEIOU]>/
        {
            my $replacement = @vowels[$vowel-index++];
            # Adjust the case of the replacement to match the original
            if $0 ~~ /<:Lu>/ {
                $replacement.tc;
            } else {
                $replacement.lc;
            }
        };

    return $s;
}

# Tests
use Test;
plan 4;
is reverse-vowels("Raku"), "Ruka", 'Test Raku';
is reverse-vowels("Perl"), "Perl", 'Test Perl';
is reverse-vowels("Julia"), "Jaliu", 'Test Julia';
is reverse-vowels("Uiua"), "Auiu", 'Test Uiua';
