#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);

## Normal print
say my $t = my $f = 1;
say $t += ($f*=$_) for 1..20;

## Pretty print!! Single lining commify....
printf "%26s\n", $t = $f = 1;
printf "%26s\n", scalar reverse ( reverse ($t += ($f*=$_)) =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/gr ) for 1..20;
