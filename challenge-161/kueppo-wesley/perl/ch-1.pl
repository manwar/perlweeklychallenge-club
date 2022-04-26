#!/usr/bin/env perl

use strict;
use warnings;

use feature 'say';
#use Test;

my %abe = ();

while ( <ARGV> ) {
    chomp;
    push @{ $abe{length()} }, $_ if join( '', sort split //, $_  ) eq $_;
}

$" = "\n";
say "@{ $abe{$_} }" foreach (sort keys %abe);
