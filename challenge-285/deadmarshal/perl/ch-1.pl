#!/usr/bin/env perl
use strict;
use warnings;

sub no_connection{
  my ($arr) = @_;
  my (%destinations,%sources);
  foreach my $r(@{$arr}){
    $sources{$r->[0]} = $destinations{$r->[1]} = 1;
  }
  foreach my $d(keys %destinations){
    return $d unless exists $sources{$d}
  }
  ""
}

printf "%s\n",no_connection([["B","C"],["D","B"],["C","A"]]);
printf "%s\n",no_connection([["A","Z"]]);

