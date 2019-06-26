#!/bin/env perl

use Modern::Perl;

my @aUSPS = qw(
    al ak az ar ca co ct de fl ga
    hi id il in ia ks ky la me md
    ma mi mn ms mo mt ne nv nh nj
    nm ny nc nd oh ok or pa ri sc
    sd tn tx ut vt va wa wv wi wy
);

my %hUSPS;
map { $hUSPS{ $_ } = 1 } @aUSPS;

my @words;
my $max_len = 0;

open my $fh, '<', '/usr/share/dict/words'  or  die "cannot read /usr/share/dict/words\n";

myloop:
while (my $w = <$fh>) {
    chomp $w;
    $w = lc($w);

    for my $p ($w =~ m/..?/g) {
        next myloop unless $hUSPS{ $p };
    }

    push @words, $w;
    my $len = length $w;
    $max_len = $len if $len > $max_len;
}
close $fh;

say "max word length is $max_len";

for my $w (@words) {
    say $w if length($w) == $max_len;
}
