#!/usr/bin/perl
#
# Write a script to generate first 20 Perfect Totient Numbers.

use strict;
use warnings;

use feature 'say';

use HTTP::Tiny;

# Laziness is good, right? Other people have calculated the sequence.
my $url = 'https://oeis.org/';
my $seq_code = 'A082897';

my $resp = HTTP::Tiny->new->get("$url$seq_code");

my ($seq) = $resp->{content} =~ /<tt>([\d,\s]+)/;

my @seq = $seq =~ /(\d+)/g;

# Truncate to 20.
$#seq = 19;

say join ', ', @seq;
