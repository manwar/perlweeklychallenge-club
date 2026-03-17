#!/usr/bin/env perl

use Modern::Perl;

my($sep, @words) = @ARGV;
my $words = join($sep, @words);
@words = grep {$_ ne ''} split /\Q$sep/, $words;
say "(", join(", ", @words), ")";
