#!/usr/bin/env perl

use v5.38;

# Upper/lowercase are usually on the same key, thus we ignore case
sub apssible { grep !/[@_\0]/i, split /\s+/, shift }
sub pssible {
    #my $re = qr/[@_\0]/i;
    #say STDERR $re;
    grep !/[@_\0]/i, split /\s+/, shift 
}

say join ' ', pssible(shift, @ARGV) if @ARGV
