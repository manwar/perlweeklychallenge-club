#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;

my @contents;
if (scalar @ARGV) {
    for my $file (@ARGV) {
        open my $fh, '<', $file or die "$OS_ERROR\n";
        local $INPUT_RECORD_SEPARATOR = undef;
        push @contents, split //, <$fh>;
        close $fh;
    }
} else {
    local $INPUT_RECORD_SEPARATOR = undef;
    push @contents, split //, <STDIN>;
}

my %totals;
for my $item (@contents) {
    $totals{lc $item}++;
}

for my $total (sort grep / \p{XPosixLower} /msx, keys %totals) {
    say "$total: $totals{$total}";
}

