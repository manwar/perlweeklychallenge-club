#!/usr/bin/perl
use 5.030;
use warnings;

my @int = @ARGV;
my %s;
my $index = 0;

for my $elem (sort { $a <=> $b } @int) {
    unless (exists $s{$elem}) {
        $s{$elem} = $index;
    }
    $index++;
}

say q{(}, (join q{, }, map { $s{$_} } @int), q{)}; 
