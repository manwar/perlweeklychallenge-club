#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw(all);

my ($input) = @ARGV;
$input //= "25525511135";

my $digs = qr/(0|[^0]\d{0,2})/;
$input =~ /^$digs$digs$digs$digs$(?{print "$1.$2.$3.$4\n" if all {$_ < 256} ($1, $2, $3, $4)})(?!)/;
