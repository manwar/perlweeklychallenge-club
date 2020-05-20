#!/usr/bin/env perl

use 5.30.0;
use warnings;
use List::Util qw(all);


my ($input) = @ARGV;
my $digs = qr/(0|[^0]\d{0,2})/;
$input =~ /^$digs$digs$digs$digs$(?{say "$1.$2.$3.$4" if all {$_ < 256} ($1, $2, $3, $4)})(?!)/;
