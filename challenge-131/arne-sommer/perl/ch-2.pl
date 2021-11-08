#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use Getopt::Long;
use Perl6::Junction 'any';

my $verbose = 0;

GetOptions("verbose" => \$verbose);

my $pairs  = shift(@ARGV) // '""[]()';
my $search = shift(@ARGV) // '"I like (parens) and the Apple ][+" they said.';

my @pairs  = split(//, $pairs);
my @search = split(//, $search);

my @open;
my @close;

for my $index (0 .. @pairs -1)
{
  $index % 2 ? push(@open, $pairs[$index]) : push(@close, $pairs[$index]);
}

say ": Open: @open"  if $verbose;
say ": Close @close" if $verbose;

my $open  = "";
my $close = "";

for my $char (@search)
{
  $open  .= $char if any(@open)  eq $char;
  $close .= $char if any(@close) eq $char;
}

say $open;
say $close;
