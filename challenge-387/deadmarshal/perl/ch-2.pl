#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub rational_numbers{
  my ($s) = @_;
  my %h;
  $s =~ s/([A-Z][a-z]?)(\d+)/$1 x $2/gex;
  1 while $s =~ s/\(([^()]+)\) (\d+)/$1 x $2/gex;
  $h{$_}++ foreach $s =~ /[A-Z][a-z]?/gx;
  join '',map {$_ . ($h{$_} > 1 ? $h{$_} : '')} sort keys %h
}

is rational_numbers('((N2O)3(H2O)2)2'),'H8N12O10','Example 1';
is rational_numbers('Mg3(PO4)2'),'Mg3O8P2','Example 2';
is rational_numbers('(((H)2)3)4'),'H24','Example 3';
is rational_numbers('NaCl3(O2(S10)2)2Mg'),'Cl3MgNaO4S40','Example 4';
is rational_numbers('Z2Y3(X2W)2'),'W2X4Y3Z2','Example 5';

done_testing();

