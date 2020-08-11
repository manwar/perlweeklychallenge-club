#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my @files = glob "./*.pl";
my %dict;
for my $file (@files) {
    open my $IN, "<", $file or die "Cannot open $file $!";
    while (my $line = <$IN>) {
        my @words = grep { /^\w{3,}$/ } split /\s+/, $line;;
        $dict{$_}{$file} = 1 for @words;
    }
    close $IN;
}
print Dumper \%dict;
