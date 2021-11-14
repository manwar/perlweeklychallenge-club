#!/usr/bin/env perl
# Week 134 Task 2
# Distinct Terms Count

use strict;
use warnings;
use feature qw/ say /;
use Text::ASCIITable;

my ( $m, $n ) = @ARGV;
my @rows;
my %distict_terms;
my $t = Text::ASCIITable->new();

( defined $m && defined $n ) && ( $m =~ /^\d+$/ && $n =~ /^\d+$/ )
    or die "2 positive integers must be passed as command line arguments\n";

for my $row ( 1 .. $m ) {
    my @multiples = map { $row * $_ } ( 1 .. $n );
    map { $distict_terms{$_} = 1 } @multiples;
    $rows[$row] = \@multiples;
}
my @distict_terms = sort { $a <=> $b } keys %distict_terms;

printf( "Input: \$m =  %d, \$n = %d\n", $m, $n );
say "Output:\n";
$t->setCols( 'x', 1 .. $n );
$t->setOptions( { hide_FirstLine => 1, hide_LastLine => 1 } );
for my $row ( 1 .. $m ) {
    $t->addRow( $row, @{ $rows[$row] } );
}
print $t;
say "\nDistinct Terms: ", join ", ", @distict_terms;
say "Count: ", scalar @distict_terms;
