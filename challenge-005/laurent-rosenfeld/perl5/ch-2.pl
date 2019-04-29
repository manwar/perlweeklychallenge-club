use strict;
use warnings;
use feature 'say';

my %words;   # our HoA
my $file_in = "words.txt";
open my $IN, "<", $file_in or die "Ouverture impossible $file_in $!";
while (my $word = <$IN>) {
    next unless $word =~ /\w/;  # skipping empty lines if any
    $word =~ s/\s+$//;          # removing trailing spaces, new lines and carriage returns (if any)
    next if length $word < 3;
    my $key = join '', sort split //, $word;  # normalizing the word for the hash key
    push @{$words{$key}}, $word;              # storing the word in the HoA
}
close $IN;
my @max_anagrams;
my $max = 5;
for my $key (keys %words) {
    next if @{$words{$key}} < $max;
    if (@{$words{$key}} == $max) {
        push @max_anagrams, $key;
    } else {
        @max_anagrams = ($key);
        $max = scalar @{$words{$key}};
    }
}
say "$_:\t @{$words{$_}}" for (@max_anagrams);
