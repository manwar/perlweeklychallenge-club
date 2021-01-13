use strict;
use warnings;
use feature qw/say/;

my $string = "perlweeklychallenge";
my @words = <weekly challenge week perl>;
my %loc;
for my $word (@words) {
    my $index = index $string, $word;
    $loc{$word} = $index if $index >= 0;
}
if (%loc == 0) {
    say "0";
} else {
    say join " ", sort { $loc{$a} <=> $loc{$b} } keys %loc;
}
