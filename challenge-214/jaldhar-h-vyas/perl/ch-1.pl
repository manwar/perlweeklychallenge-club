#!/usr/bin/perl
use 5.030;
use warnings;
use experimental qw/ switch /;

my @scores = @ARGV;
my %quantities;
map { $quantities{$_}++ } @scores;

my @ordered = sort { $b <=> $a } @scores;
my %ranks;
my $currentRank = 1;
my $quantity = 0;

for my $i (0 .. scalar @ordered - 1) {
    if ($quantity == 0) {
        $quantity = $quantities{$ordered[$i]};
    }
    $quantity--;

    given ($currentRank) {
        when (1) { $ranks{$ordered[$i]} = 'G' };
        when (2) { $ranks{$ordered[$i]} = 'S' };
        when (3) { $ranks{$ordered[$i]} = 'B' };
        default { $ranks{$ordered[$i]} = $currentRank; }
    }

    if ($quantity == 0) {
        $currentRank += $quantities{$ordered[$i]};
    }
}

say q{(}, ( join q{,}, map { $ranks{$_}; } @scores ), q{)};
