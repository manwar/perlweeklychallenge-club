#!/usr/bin/perl

use strict;
use warnings;

my $string = $ARGV[0] || '  hello world';
my $regex  = $ARGV[1] || qr/[ea]l/;

print last_word($string, $regex), "\n";

sub last_word {
    my ($string, $regex) = @_;

    return [ grep /$regex/, reverse ( split /\s/, $string ) ]->[0];
}
