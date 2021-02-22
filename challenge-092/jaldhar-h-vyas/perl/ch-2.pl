#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
  $PROGRAM_NAME [<S> ...]

    [<S> ...]    A set of sorted non-overlapping intervals enclosed in
                 parentheses and separated by commas. The last pair will
                 be merged into the rest.
-USAGE-
    exit 0;
}

sub toArray {
    my ($arg) = @_;
    $arg =~ /\( (\d+) , (\d+) \) /gmx;
    return [$1, $2];
}

if (scalar @ARGV < 2) {
    usage;
}

my @intervals = sort { $a->[0] <=> $b->[0] } map { toArray($_); } @ARGV;

my $size = scalar @intervals;
my @merged;

for (my $i = 0; $i < $size; $i++) {
    my $start = $intervals[$i]->[0];
    my $end = $intervals[$i]->[1];

    while ($i < $size - 1 &&
    $end >= $intervals[$i + 1]->[0] && $end <= $intervals[$i + 1]->[1]) {
        $end = $intervals[$i + 1]->[1];
        $i++;
    }

    push @merged, [$start, $end];
}

say join ', ', map { "($_->[0],$_->[1])" } @merged;