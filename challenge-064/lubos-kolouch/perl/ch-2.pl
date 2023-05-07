use strict;
use warnings;

sub word_sequence {
    my ($S, $W) = @_;
    return helper($S, $W, []);
}

sub helper {
    my ($s, $W, $words) = @_;
    return $words unless $s;

    for my $word (@$W) {
        if (index($s, $word) == 0) {
            my $result = helper(substr($s, length($word)), $W, [@$words, $word]);
            return $result if @$result;
        }
    }

    return [];
}

my $S1 = "perlweeklychallenge";
my $W1 = ["weekly", "challenge", "perl"];

my $S2 = "perlandraku";
my $W2 = ["python", "ruby", "haskell"];

print join(', ', @{word_sequence($S1, $W1)}), "\n";  # Output: perl, weekly, challenge
print join(', ', @{word_sequence($S2, $W2)}), "\n";  # Output: 0

