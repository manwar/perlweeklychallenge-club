#!/usr/bin/env perl

use strict;
use warnings;
use v5.10;

use Data::Dumper;

# all state short codes
my %states = map { $_ => 1 } qw(AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY);

# unique letters contained in these codes (any word matching any letter not in this list is right out)
my %uniq = map { $_ => 1 } map { split // } keys %states;
my $uniq = join '', sort { $a cmp $b } keys %uniq;
my $notok = qr/[^$uniq]/; # by my calculations, should be missing B and Q

my $file = '/usr/share/dict/american-english-insane';
$file = '/usr/share/dict/american-english-huge' if ! -e $file;
$file = '/usr/share/dict/words' if ! -e $file;

open my $words, '<', $file or die $!;
my $longest = '';
WORD: foreach my $word (<$words>) {
    chomp $word;
    $word = uc $word;
    next if $word =~ $notok;                   # skip words that contain an invalid character (especially B or Q but also punctuation and accents)
    next if length($word) % 2 == 1;            # skip odd length words, they can't consist of pairs
    next if length($word) <= length($longest); # skip words that aren't longer than the current longest
    my @pairs = $word =~ m/../g;
    foreach my $pair (@pairs) {
        next WORD if ! $states{$pair};         # skip words that have a pair that doesn't match a state
    }
    $longest = $word;
    #say $word;
}
say $longest;

# CONCORDE
# OR
# CACOGALACTIA
#
# depending on the dictionary available
