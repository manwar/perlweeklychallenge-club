#!/usr/bin/perl
use 5.030;
use warnings;

my $s = shift // die "need a string in quotation marks\n";
my %chars;

my $pos = 0;
for my $c (split //, $s) {
    if (exists $chars{$c}) {
        $chars{$c} = "Inf";
    } else {
        $chars{$c} = $pos;
    }
    $pos++;
}

say $chars{ (sort { $chars{$a} <=> $chars{$b}} keys %chars)[0] };
