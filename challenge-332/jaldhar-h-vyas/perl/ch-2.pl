#!/usr/bin/perl
use 5.038;
use warnings;
use English;

my $str = shift // die "Usage: $PROGRAM_NAME string\n";
my @letters = split //, $str;
my %count;

for my $letter (@letters) {
    $count{$letter}++;
}

for my $n (values %count) {
    if ($n % 2 == 0) {
        say "False";
        exit;
    }
}

say "True";
