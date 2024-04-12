#!/usr/bin/perl
use 5.030;
use warnings;

my $str = shift;

my %upper;
my %lower;

for my $char (split //, $str) {
    if ($char =~ /[[:upper:]]/) {
        $upper{$char} = 1;
    } else {
        $lower{$char} = 1;
    }
}

my $greatest = undef;
for my $char (sort keys %upper) {
    if (exists $lower{chr((ord $char) + (ord ' '))}) {
        $greatest = $char;
    }
}

say $greatest // q{''};