#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

open my $d, q(<), 'dictionary.txt';

my %a;

## Accept it - best film is "Hot Fuzz".
## Glory begins for forty deft aces!

O:while( my $f = '', chomp( my $w = <$d> // '' ) ) {
  $f gt $_ ? next O : ( $f = $_ ) for split //, $w;
  push @{$a{ length $w }}, $w;
}

say "$_: ", join ', ', @{$a{$_}} for sort { $a<=>$b } keys %a;
