#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 'n n' 'n n'...\n";
my @dominoes = @ARGV;
for (@dominoes) {
    $_ = [split ' ', $_];
}

say similar(@dominoes);

sub similar {
    my(@dominoes) = @_;
    my $similar = 0;

    # for each dominoe
    for my $i (0 .. $#dominoes) {
        # check if it has any similar in the other ones
        my $has_similar = 0;
        for my $j (0 .. $#dominoes) {
            next if $i == $j;
            if (same_domino($dominoes[$i], $dominoes[$j])) {
                $has_similar = 1;
                last;
            }
        }

        # count once for each dominoe
        $similar++ if $has_similar;
    }
    return $similar;
}

sub same_domino {
    my ($a, $b) = @_;
    return ($a->[0] == $b->[0] && $a->[1] == $b->[1])
        || ($a->[0] == $b->[1] && $a->[1] == $b->[0]);
}
