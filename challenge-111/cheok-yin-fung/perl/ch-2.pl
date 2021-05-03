#!/usr/bin/perl
# The Weekly Challenge 111
# Ordered Letters
# Default Word List: 
# http://www-personal.umich.edu/~jlawler/wordlist.html
use strict;
use warnings;

my $dictfile;

if ($ARGV[0]) {
    $dictfile = $ARGV[0];
} 
else {
    $dictfile = "word_list";
}

open DICT, "<", $dictfile 
        or die "no such text file for the dictionary: $dictfile";

my @max_club;
my $max_len = 1;

foreach my $w (<DICT>) { 
    chomp($w);
    $w =~ s/\r//g;
    if (length $w >= $max_len) {  #only test those long words
        my $w_ord = join "" , sort(split //, $w);
        if ($w eq $w_ord) {
            if ((length $w) > $max_len) {
                update_max($w);
            } else {
                push @max_club, $w;
            }
        }       
    }
}

print join "\n", @max_club;
print "\n";

sub update_max {
    @max_club = ($_[0]);
    $max_len = length $_[0];
}

# result: aegilops, with length = 9

# for most common 1000 English words:
# accept, almost, effort,  with length = 7

