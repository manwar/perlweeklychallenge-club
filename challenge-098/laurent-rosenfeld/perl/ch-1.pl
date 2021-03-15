use strict;
use warnings;
use feature qw/say/;

my $input = shift // "I_have_a_dream.txt";
open my $IN, "<", $input or die "Cannot open $input $!";
for my $n (4..7) {
    say "Taking $n characters: ", map getc $IN, 1..$n;
}
