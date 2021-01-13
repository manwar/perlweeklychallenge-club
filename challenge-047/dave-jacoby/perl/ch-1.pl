#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
  qw{ experimental::postderef experimental::smartmatch experimental::signatures };

use Roman;

my %operators = map { $_ => 1 } qw{ + - / * };

if ( scalar @ARGV > 2 ) {
    my ( $r1, $op, $r2 ) = @ARGV;
    if ( !$operators{$op} ) {
        say 'not an operator';
        exit;
    }
    if ( !isroman($r1) ) { say qq{"$r1" is not a roman numeral}; exit; }
    if ( !isroman($r2) ) { say qq{"$r2" is not a roman numeral}; exit; }
    my $a1 = arabic($r1);
    my $a2 = arabic($r2);
    my $a3 = 0;
    if ( $op eq '+' ) { $a3 =  $a1 + $a2 }
    if ( $op eq '-' ) { $a3 =  $a1 - $a2 }
    if ( $op eq '*' ) { $a3 =  $a1 * $a2 }
    if ( $op eq '/' ) { $a3 =  $a1 / $a2 }
    my $r3 = uc roman($a3);
    say qq{ $r1 $op $r2 = $r3 };
}
else { say 'We need an operator and two roman numbers' }
