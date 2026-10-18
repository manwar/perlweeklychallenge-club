#!/usr/bin/perl
use 5.40.1;
use warnings;

my @words = @ARGV;

my $size = length $words[0];
my @grid;
my %used;

sub search($prefix) {
    if (scalar @grid == $size) {
        return true;
    }

    for my $word (grep { /^$prefix/ } @words) {
        if (exists $used{$word}) {
            next;
        }

        push @grid, $word;
        $used{$word} = true;

        my $column = scalar @grid;
        my $nextPrefix = join q{}, map { substr $_, $column, 1 } @grid;

        if (search($nextPrefix)) {
            return true;
        }

        pop @grid;
        delete $used{$word};
    }

    return false;
}

search(q{});

say q{(}, (join q{, }, map{ "\"$_\"" } @grid), q{)};
