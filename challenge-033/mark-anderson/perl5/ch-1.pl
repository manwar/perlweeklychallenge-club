#!/usr/bin/env perl

use Modern::Perl '2018';
use Mojo::File 'path';

die "Please provide 1 or more files:$!" unless @ARGV;

my %count;

while (@ARGV) {
  my $slurp = path(shift)->slurp;
  my @letters = split //, $slurp;
      @letters = grep { /[[:alpha:]]/ } @letters;

    foreach my $letter (@letters) {
        $count{lc $letter}++;
    }
}

foreach my $letter (sort keys %count) {
    say "$letter: $count{$letter}";
}
