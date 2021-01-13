#!/usr/bin/perl

# Perl Weekly Challenge - 071
#
# Task 2 - Trim Linked List
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use Data::LinkedList;

sub printList ($$);
sub removeAt ($$);


my ($N) = @ARGV;
die "Argument must be a positive number"
  unless (defined $N && $N =~ m#^[1-9][0-9]*#);

my @L = qw(1 2 3 4 5);

my $ll = Data::LinkedList->new();
$ll->add_all(@L);

printList('Given Linked List', $ll);
removeAt($ll, $N);
print "when \$N = $N\n";
printList('Output', $ll);


sub printList ($$) {
  my ($label, $myLl) = @_;

  printf "$label: %s\n", join(' -> ', $myLl->to_array);
}


sub removeAt ($$) {
  my ($myLL, $i) = @_;

  my $size = $myLL->size;

  my $index = $size - $i > 0 ? $size - $i : 0;

  $myLL->remove_at($index);
}
