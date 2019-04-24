use strict;
use warnings;
use v5.10;
use utf8;
use open qw(:std :utf8);
use FindBin;

# Challenge #2
# Write a program to find the sequence of characters that has the most anagrams.

# The solution is based on challenge 1, using the same "canonical" function.

sub canonical {
    my $inp = lc shift;
    $inp =~ tr/áéíóú/aeiou/; # anagrams in spanish don't care about accents
    return join '', sort split '', $inp;
}

# The list of spanish words is also from challenge 1

open( my $words_file, "$FindBin::Bin/palabras.txt" );
my @words = <$words_file>;
chomp @words;

my %cant;

# we will use this hash to store the amount of repetitions of the "canonical" results
# so the maximum in the values of %cant hash will correspond to the sequence of
# characters that has the most anagrams
# Caveat: may be more than one!

$cant{ canonical($_) }++ for @words;

# now we can find maximum repetitions (# of anagrams)

my $max = -1;
$max = $max < $cant{$_} ? $cant{$_} : $max for keys %cant;

# and just print the results

say "Secuence(s) of characters with most anagrams ($max):";
$cant{$_} == $max && say for sort keys %cant;

# the `sort' here is not really needed, it is just to force the order
# of the results to be predictable
#
# for this spanish words list, the maximum amount of anagrams is 16,
# corresponding to 2 secuences:
#
# $> perl ch-2.pl
# Secuence(s) of characters with most anagrams (16):
# aaerrst
# aceorst
#
# Lastly, you can plug each of these secuences in challenge-1 script, and get
# the actual anagrams for each case:
#
# $> perl ch-1.pl aaerrst
# arresta
# arteras
# aterras
# erratas
# etarras
# rastrea
# rateras
# restara
# restará
# retaras
# retarás
# retasar
# retraas
# retrasa
# traerás
# trasera
# $>
#
# perl ch-1.pl aceorst
# acortes
# actores
# atroces
# caretos
# carteos
# coartes
# cortesa
# costaré
# costear
# costera
# croaste
# escotar
# recatos
# rescato
# rescató
# retocas
#
