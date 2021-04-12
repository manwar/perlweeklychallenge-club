#!/usr/bin/perl
use warnings;
use v5.12;

# run <script>

use bignum qw/hex/;

my $x=5;
say qq|The variable \$x has value $x and address ${\ do{hex(sprintf("%p", $x))}}.|;
