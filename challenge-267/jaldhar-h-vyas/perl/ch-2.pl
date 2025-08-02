#!/usr/bin/perl
use v5.38;

sub unique(@list) {
    my %elems;
    for (@list) {
        $elems{$_}++;
    }

    return keys %elems;
}

my ($str, @widths) = @ARGV;

my @letters = split //, $str;
my %widthmap = map { $_ => @widths[ord($_) - ord('a')] } sort unique(@letters);
my $freespace = 100;
my $lines = 1;

for my $letter (@letters) {
    if ($freespace < $widthmap{$letter}) {
        $lines++;
        $freespace = 100;
    }

    $freespace -= $widthmap{$letter};
}

say "($lines, ", 100 - $freespace, ')';
