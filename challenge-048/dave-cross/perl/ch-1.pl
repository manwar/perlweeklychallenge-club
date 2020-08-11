#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @people = (undef, (1) x 50);

my $person_with_sword = 1;

while () {
  kill_someone($person_with_sword, \@people);
  last unless more_than_one_person(@people);
  $person_with_sword = hand_over_sword($person_with_sword, \@people);
}

say "Last living person is #$person_with_sword";

sub more_than_one_person {
  my $count = grep { $_ } @_;
  return $count > 1;
}

sub get_next_living_person {
  my ($curr_person, $people) = @_;
   
  while (1) {
    ++$curr_person;
    $curr_person = 1 if $curr_person > $#$people;

    return $curr_person if $people->[$curr_person];
  }
}

sub kill_someone {
  my ($curr_person, $people) = @_;

  my $person_to_kill = get_next_living_person($curr_person, $people);
  $people->[$person_to_kill] = 0;

  # say "$curr_person killed $person_to_kill";

  return $person_to_kill;
}

sub hand_over_sword {
  my ($curr_person, $people) = @_;

  return get_next_living_person($curr_person, $people);
}
