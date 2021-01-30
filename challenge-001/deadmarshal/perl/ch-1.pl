#!/usr/local/bin/perl
use strict;
use warnings;
use feature 'say';


my $string = "Perl weekly challenge";

my $count = $string =~ s/e/E/g;

print $string, "\n";
print $count, "\n";
