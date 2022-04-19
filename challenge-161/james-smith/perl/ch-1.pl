#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

open my $d, q(<), 'dictionary.txt';

my %a;

O:while( my $f = '', chomp( my $w = <$d> // '' ) ) {
  $f gt $_ ? next O : ( $f = $_ ) for split //, $w;
  push @{$a{ length $w }}, $w;
}

say "$_: ", join ', ', @{$a{$_}} for sort { $a<=>$b } keys %a;
