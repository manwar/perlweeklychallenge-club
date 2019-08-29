#!/usr/bin/env perl

use Modern::Perl '2018';
use Getopt::Long;

#usage: perl ch-1.pl -n=2 -- -11 13 -13 12;

my $n = 1;
GetOptions('n=i' => \$n) ;

my @X = (5, 9, 2, 8, 1, 6);
@X = @ARGV if @ARGV;

while($n and @X > 1) {
    my @Y;
    foreach my $i (0 .. ($#X - 1)) {
        push @Y, $X[$i+1] - $X[$i];
    }
    $n--;
    @X = @Y;
}

$" = ", ";
say "@X";
