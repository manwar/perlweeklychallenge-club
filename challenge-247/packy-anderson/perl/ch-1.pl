#!/usr/bin/env perl
use v5.38;

use List::Util qw( sample );

sub findRecipient($giver, $recipients) {
  # since $recipients is a reference to a hash, we can't
  # modify it, so let's make a copy with the giver removed
  my @recipients = grep { !/$giver/ } keys %$recipients;

  # split on whitespace and take the last element
  # to get the "family name"
  my $family_name = (split /\s+/, $giver)[-1];

  # now, make a potential recipient hash
  # excluding family members
  my @non_family_members =
    grep { !/$family_name/ } @recipients;

  if (@non_family_members > 0) {
    return sample(1, @non_family_members);
  }
  else {
    return sample(1, @recipients);
  }
}

sub secretSanta(@names) {
  # let's use a hash to hold the giver/recipient pairings
  my %results;
 
  # put our work in a labelled loop
  ASSIGN_RECIPIENTS: while () {
    # convert the array of names into a hash with names as keys
    my %available_recipients = map { $_ => 1 } @names;

    # now go through each of the names and find a
    # recipient for them
    foreach my $giver ( @names ) {
      my $recipient =
        findRecipient($giver, \%available_recipients);

      # occasionally, we assign recipients so in the last
      # iteration of the for loop the only available
      # recipient is $giver. When that happens, the easiest
      # way to fix things is to just re-do the entire list
      redo ASSIGN_RECIPIENTS if ! defined $recipient;

      $results{$giver} = $recipient;
      delete $available_recipients{$recipient};
    }
    last; # exit the labelled loop
  }
  return %results;
}

sub solution(@names) {
  say "Input: \@names = ('"
    . join("',\n                 '", @names)
    . "')";
  my %recipients = secretSanta(@names);
  say "Output:";
  foreach my $giver ( @names ) {
    say "    $giver -> $recipients{$giver}";
  }
}

say "Example 1:";
solution('Mr. Wall', 'Mrs. Wall', 'Mr. Anwar',
         'Mrs. Anwar', 'Mr. Conway', 'Mr. Cross');

say "\nExample 2:";
solution('Mr. Wall', 'Mrs. Wall', 'Mr. Anwar');