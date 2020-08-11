#!/usr/bin/perl

# Perl Weekly Challenge - 068
#
# Task 1 - ReorderList
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use Data::LinkedList;

sub printList ($$);
sub reorderList ($);


my @L = qw(L0 L1 L2 L3 L4 L5 L6 L7);

my $ll = Data::LinkedList->new();
$ll->add_all(@L);

printList('Input', $ll);
reorderList($ll);
printList('Output', $ll);


sub printList ($$) {
  my ($label, $myLl) = @_;

  printf "$label: %s\n", join(' -> ', $myLl->to_array);
}


sub reorderList ($) {
  my ($myLl) = @_;

  my $size = $myLl->size;

  my $i = 1;
  while ($i < $size) {
    $myLl->insert($i, $myLl->remove_last);
    $i += 2;
  }
}
