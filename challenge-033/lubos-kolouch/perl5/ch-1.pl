#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-033/
#
#  Count Letters (A..Z)

#Create a script that accepts one or more files specified on the command-line and count the number of times letters appeared in the files.
#
#So with the following input file sample.txt
#
#The quick brown fox kumps over the lazy dog.
#
#the script would display something like:
#
#a: 1
#b: 1
#c: 1
#d: 1
#e: 3
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch, 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 11/10/2019 03:03:39 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;

my %letter;

while (<>) {

    # process the files, split them to characters
    for (split //) {
        # count only A to Z
        next unless lc($_) =~ /[a-z]/msx;

        # increase the count of the lowercase character
        $letter{lc($_)}++;
    }
}

for ('a'..'z') {
    # if the letter was not seen, it is 0
    $letter{$_} //=0;

    say $_.':'.$letter{$_};
}

