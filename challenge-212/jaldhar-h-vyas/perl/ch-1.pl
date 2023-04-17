#!/usr/bin/perl
use 5.030;
use warnings;

my $word = shift;
my @jump = @ARGV;

my @letters = split //, $word;
for my $i (0 .. scalar @letters - 1) {
    my $aord =  $letters[$i] =~ /[[:upper:]]/ ? ord 'A' : ord 'a'; 
    @letters[$i] = 
        chr(((((ord $letters[$i]) - $aord) + $jump[$i]) % 26) + $aord);
}

say join q{}, @letters;
