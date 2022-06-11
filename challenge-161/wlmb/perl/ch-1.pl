#!/usr/bin/env perl
# Perl weekly challenge 161
# Task 1: Abecedarian words
#
# See https://wlmb.github.io/2022/04/11/PWC160/#task-1-abecedarian-words
use v5.12;
use warnings;
use Text::Wrap qw(wrap $columns $break);
die "Usage: ./ch-1.pl dictionary\n".
    "to find all abecedarian words in the given dictionary..."
    unless @ARGV==1;
die "Can't read dictionary" unless -r $ARGV[0];
$columns=62; $break=qr/\s/;
# Read the comments from the bottom up
say wrap "", "", # pretty print
	 join " ", # join into line
	 sort {length $b <=> length $a} # sort by decreasing length
	 grep {$_  eq # compare to original word and filter
		    join "", # join into new word
		   sort {$a cmp $b} # sort them
	       split "", $_} # separate letters
	 map {chomp; $_} # Remove line end
	 <>; # Read all the dictionary, one word per line
