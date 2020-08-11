#!/usr/bin/perl

use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;

sub process {
    my ($filename, $index) = @_;
    open my $fh, '<', $filename or die "$OS_ERROR!";
    my $lineno = 0;
    while (my $line = <$fh>) {
        $lineno++;
        my @words = split /\W+/msx, $line;
        for my $word (@words) {
            push @{$index->{$word}}, { document => $filename, line => $lineno };
        }
    }
    close $fh or die "$OS_ERROR\n";
}

my %index;

for my $file (@ARGV) {
    process($file, \%index);
}


for my $word (sort keys %index) {
    say $word;
        for my $entry (sort { $a->{document} cmp $b->{document} } @{$index{$word}}) {
            say q{ }, $entry->{document}, ' - ', $entry->{line}; 
        }
 }