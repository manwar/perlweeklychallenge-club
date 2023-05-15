use strict;
use warnings;

sub last_word {
    my ($string, $regexp) = @_;
    my @words = $string =~ /(\S+)/g;
    my $last_word;

    for my $word (@words) {
        $last_word = $word if $word =~ $regexp;
    }

    return $last_word;
}

print last_word('  hello world',                qr/[ea]l/) || "undef", "\n";      # 'hello'
print last_word("Don't match too much, Chet!",  qr/ch.t/i) || "undef", "\n";      # 'Chet!'
print last_word("spaces in regexp won't match", qr/in re/) || "undef", "\n";      #  undef
print last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/) || "undef", "\n"; # '399933'

