#!/usr/bin/perl
use 5.030;
use warnings;

my $number = shift // die "need an integer\n";
my @truth = qw/ abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg /;
my @segments = (
            [qw/ - a a a a a a a /],
            [qw/ - F - - - - - B /],
            [qw/ - F - - - - - B /],
            [qw/ - g g g g g g g /],
            [qw/ - E - - - - - C /],
            [qw/ - E - - - - - C /],
            [qw/ - d d d d d d d /],
);
my @template = map { $truth[$_]; } split //, $number;
my $offset = 0;
my @result;
for my $i (0 .. 6) {
    for my $j (0 .. (length $number) * 8 - 1) {
        $result[$i][$j] = q{ };
    }
}

for my $digit (@template) {
    for my $segment (split //, $digit) {
        for my $row (0 .. 6) {
            for my $column (0 .. 7) {
                if (lc $segments[$row][$column] eq $segment) {
                    $result[$row][$offset + $column] =
                        ($segments[$row][$column] =~ /[A-Z]/) ? q{|} : q{-};
                }
            }
        }
    }
    $offset += 8;
}

for my $i (0 .. 6) {
    say join q{}, @{$result[$i]};
}
