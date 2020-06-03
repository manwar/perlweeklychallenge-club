use strict;
use warnings;
use feature 'say';

sub last_word {
    my ($str, $regex) = @_;
    for my $reversed (reverse split /\s+/, $str) {
        return $reversed if $reversed =~ $regex;
    }
    return "Not found";
}

say last_word('  hello world',                qr/[ea]l/);
say last_word("Don't match too much, Chet!",  qr/ch.t/i);
say last_word("spaces in regexp won't match", qr/in re/);
say last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/);
