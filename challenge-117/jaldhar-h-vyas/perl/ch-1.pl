#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

my $filename = shift // die "Must specify a filename.\n";

open my $file, '<', $filename or die "$OS_ERROR\n"; 
local $RS = undef;
my $contents = <$file>;
close $file;

my @lines =
    sort { $a <=> $b }
    map { / ^ (\d+) /x; int ${^CAPTURE}[0]; }
    split /\n/, $contents;

my $counter = 1;
for my $line (@lines) {
    if ($counter != $line) {
        say $counter;
        last;
    }
    $counter++;
}
