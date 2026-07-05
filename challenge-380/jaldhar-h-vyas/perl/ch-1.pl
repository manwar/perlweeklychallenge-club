#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($str) = @ARGV;
my %freq = map { $_ => 0 } 'a'..'z';

$str =~ s/(.)/$freq{$1}++/ger;

my %vowels;
for my $vowel (qw/ a e i o u/) {
    $vowels{$vowel} = delete $freq{$vowel};
}

say $vowels{ (sort { $vowels{$b} <=> $vowels{$a}} keys %vowels)[0] } +
    $freq{ (sort { $freq{$b} <=> $freq{$a} } keys %freq)[0] };
