#!/usr/bin/perl
use 5.40.1;
use warnings;

sub max($a, $b) {
    return $a > $b ? $a : $b;
}

my ($fs) = @ARGV;


$fs =~ s/\\n/\n/g;
$fs =~ s/\\t/\t/g;
my @entries = split /\n/, $fs;
my @names;
my @depths;

for my $entry (@entries) {
    $entry =~ /^(\t*)(.*)$/;
    push @depths, length $1;
    push @names, $2;
}

my @pathLengths;
my $longestPath = 0;

for my ( $index, $name) (indexed @names) {
    my $depth = $depths[$index];
    my $pathLength = length $name;
    if ($depth > 0) {
        $pathLength += $pathLengths[$depth - 1] + 1;
    }
    $pathLengths[$depth] = $pathLength;

    my $hasChildren = $index + 1 < scalar @entries
        && $depths[$index + 1] > $depth;
    if ($name =~ /\./ && !$hasChildren) {
        $longestPath = max($longestPath, $pathLength);
    }
}

say $longestPath;
