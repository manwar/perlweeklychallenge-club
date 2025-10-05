#!/usr/bin/env perl

use v5.38;

# Upper/lowercase are usually on the same key, thus we ignore case
sub pssible { grep !/[@_\0]/i, split /\s+/, shift }

say join ' ', pssible(shift, @ARGV) if @ARGV
