#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

my $filename = shift // die "Need a filename\n";

open my $file, '<' , $filename or die "$OS_ERROR\n";
local $RS = undef;
my @lines = split "\n", <$file>;
close $file;

my $longest = q{};

for my $line (@lines) {
    chomp $line;
    if (lc $line eq (join q{}, sort split //, lc $line) &&
    length $line > length $longest) {
        $longest = $line;
    }
}

say $longest;
