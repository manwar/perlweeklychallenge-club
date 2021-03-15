use v5.30;
use feature 'signatures';

sub reverse_words ($S) {
    return join " ", reverse split " ", $S;
}

## main
my @examples = (
    "The Weekly Challenge",
    "    Perl and   Raku are  part of the same family  ",
    "join reverse split \$S",
);

for my $S (@examples) {
    say "Input: $S";
    say "Output: " . reverse_words($S);
}
