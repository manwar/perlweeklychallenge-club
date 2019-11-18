#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my %histo;

while (<>) {
    chomp;
    my $line = lc;
    for my $letter (split //, $line) {
        $histo{$letter}++ if $letter =~ /[a-z]/;
    }
}
for my $key ("a".."z") {
    say "$key: ", $histo{$key} // 0;
}
