#!/usr/bin/perl
use 5.030;
use warnings;
use English qw/ -no_match_vars /;

# Boy abhors forty cent eggs; cost is crux. Cops chip in, buy a box for him.

# Hippy most ably aces dirty cello ditty.  Accept or boo? 

my @abcde;

open my $dictionary, '<', 'dictionary.txt' or die "$OS_ERROR\n";
while (my $line = <$dictionary>) {
    chomp $line;
    my $word = $line;
    if ($word eq join q{}, sort split //, $word) {
        push @abcde, $word;
    }
}
close $dictionary;

for my $word (sort { length $b <=> length $a } @abcde) {
    say $word;
}
