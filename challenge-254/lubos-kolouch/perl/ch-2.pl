use strict;
use warnings;

sub reverse_vowels {
    my ($s)    = @_;
    my @vowels = reverse( $s =~ /[aeiou]/ig );
    my @chars  = split //, $s;

    # Replace vowels in the string with reversed vowels
    for my $i ( 0 .. $#chars ) {
        if ( $chars[$i] =~ /[aeiouAEIOU]/ ) {
            my $replacement = shift @vowels;

            # Adjusting case of the replacement vowel to match original
            if ( $chars[$i] =~ /[AEIOU]/ ) {
                $replacement = uc($replacement);
            }
            else {
                $replacement = lc($replacement);
            }
            $chars[$i] = $replacement;
        }
    }

    return join '', @chars;
}

# Tests
use Test::More;
ok( reverse_vowels("Raku") eq "Ruka",   'Test Raku' );
ok( reverse_vowels("Perl") eq "Perl",   'Test Perl' );
ok( reverse_vowels("Julia") eq "Jaliu", 'Test Julia' );
ok( reverse_vowels("Uiua") eq "Auiu",   'Test Uiua' );
done_testing();
