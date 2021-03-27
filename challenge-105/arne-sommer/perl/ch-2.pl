#! /usr/bin/env perl

use strict;
use warnings;

use feature 'say';
use Getopt::Long;
use Perl6::Junction 'any';

my $y_is_a_vowel = 0;

GetOptions("y_is_a_vowel" => \$y_is_a_vowel);

my $x = shift(@ARGV) // die 'Please specify the name';

my @vowels = $y_is_a_vowel ? qw/a e i o u y/ : qw/a e i o u/;

my $y = lc(substr($x,0,1)) eq any(@vowels) ? lc($x) : substr($x, 1);

say "$x, $x, bo-",      ( lc(substr($x,0,1)) eq "b" ? $y : "b$y" );
say "Bonana-fanna fo-", ( lc(substr($x,0,1)) eq "f" ? $y : "f$y" );
say "Fee fi mo-",       ( lc(substr($x,0,1)) eq "m" ? $y : "m$y" );
say "$x!";
