use strict;
use warnings;
use List::Util 'shuffle';

sub jumble_word {
    my ($word) = @_;

    return $word if length($word) <= 3;

    my $middle  = substr($word, 1, -1);
    my @m_chars = split('', $middle);
    @m_chars    = shuffle(@m_chars);

    my $subst = join('', @m_chars);
    substr($word, 1, -1, $subst);

    return $word;
}

sub jumble_text {
    my ($text) = @_;

    my @tokens = split(/(\W+|_)/, $text);

    for my $token (@tokens) {
        if ($token =~ /^[A-Za-z]+$/) {
            $token = jumble_word($token);
        }
    }

    return join('', @tokens);
}

my $input_text = "According to a research at Cambridge University, it doesn't matter in what order the letters in a word are.";
my $jumbled_text = jumble_text($input_text);
print "$jumbled_text\n";

1;