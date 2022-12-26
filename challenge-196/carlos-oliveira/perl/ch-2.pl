use strict;
use warnings;
use Data::Dump;
use List::MoreUtils qw(slideatatime);


sub intervals {
  my $isRegistering = 0;
  my $begin;
  my @intervals;
  my $iterator = slideatatime 1, 2, @_;

  # iterator fills with undef the free slots of the last window
  while (my ($firstItem, $secondItem) = $iterator->()) {
    unless (defined $secondItem && $firstItem + 1 == $secondItem) {
      if ($isRegistering) {
        push @intervals, [$begin, $firstItem];
      }
      $isRegistering = 0;
      next;
    }
    unless ($isRegistering) {
      $isRegistering = 1;
      $begin = $firstItem;
    }
  }

  return @intervals;
}

dd intervals(1,3,4,5,7);
dd intervals(1,2,3,6,7,9);
dd intervals(0,1,2,4,5,6,8,9);
