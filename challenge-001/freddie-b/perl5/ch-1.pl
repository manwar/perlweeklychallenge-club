#!/usr/bin/perl

#Write a script to replace the character ‘e’ with ‘E’ in the string ‘Perl Weekly Challenge’.
#Also print the number of times the character ‘e’ found in the string.

my $string = 'Perl Weekly Challenge';
my $count = $string =~ s/e/E/g;
print "$count substitutions\n";
