#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;
use Getopt::Long;

my $csv = undef;

GetOptions('csv' => \$csv);

my @contents;
if (scalar @ARGV) {
    for my $file (@ARGV) {
        open my $fh, '<', $file or die "$OS_ERROR\n";
        local $INPUT_RECORD_SEPARATOR = undef;
        push @contents, split /\n/, <$fh>;
        close $fh;
    }
} else {
    local $INPUT_RECORD_SEPARATOR = undef;
    push @contents, split /\n/, <STDIN>;
}

my %totals;
for my $item (@contents) {
    chomp $item;
    $totals{$item}++;
}

if ($csv) {
    for my $total (sort keys %totals) {
        say "$total,$totals{$total}";
    }
} else {
    my $width =
        length ((sort {length $b <=> length $a} keys %totals)[0]);

    for my $total (sort keys %totals) {
        printf("% -*s  %s\n", $width, $total, $totals{$total});
    }
}
