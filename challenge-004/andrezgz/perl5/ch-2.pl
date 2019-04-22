#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-004/
# Challenge #2
# You are given a file containing a list of words (case insensitive 1 word per line) and a list of letters.
# Print each word from the file than can be made using only letters from the list.
# You can use each letter only once (though there can be duplicates and you can use each of them once),
# you don’t have to use all the letters.

use strict;
use warnings;

die "Usage: ch-2.pl <words_file> <letters_list>" if scalar(@ARGV) < 2;

my $words_file = $ARGV[0];
my $letters_list = $ARGV[1];

#Make a hash with available letters and quantity
my %letters;
for my $l (split /,/,$letters_list ){
    $letters{ lc($l) }++;
}

open(my $fh, "<", $words_file) or die "Could not open words file '$words_file': $!";

while( my $word = <$fh> ) {
    chomp $word; #remove new line trailing string
    print $word.$/ if is_word_printable( lc $word , %letters );
}
close $fh;

#Return 1 if $word is composed by letters on the hashed list %letters
sub is_word_printable {
    my ( $word, %letters ) = @_;
    foreach my $l (split //,$word ){
        return 0 unless (exists $letters{ $l } && $letters{ $l } > 0);
        $letters{ $l }--;
    }
    return 1;
}