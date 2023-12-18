#!/usr/bin/env raku
use v6;

sub findRecipient($giver, %recipients) {
  # since %recipients is passed by reference, we can't
  # modify it, so let's make a copy with the giver removed
  my @recipients = %recipients.keys.grep({ !/$giver/ });

  # split on whitespace and take the last element
  # to get the "family name"
  my $family_name = split(" ", $giver)[*-1];

  # now, make a potential recipient hash
  # excluding family members
  my @non_family_members =
    @recipients.grep({ !/$family_name/ });

  if (@non_family_members > 0) {
    return @non_family_members.pick;
  }
  else {
    return @recipients.pick;
  }
}

sub secretSanta(@names) {
  # let's use a hash to hold the giver/recipient pairings
  my %results;
 
  # put our work in a labelled loop
  ASSIGN_RECIPIENTS: loop {
    # convert the array of names into a hash with names as keys
    my %available_recipients = @names.map: * => 1;

    # now go through each of the names and find a
    # recipient for them
    for @names -> $giver {
      my $recipient =
        findRecipient($giver, %available_recipients);

      # occasionally, we assign recipients so in the last
      # iteration of the for loop the only available
      # recipient is $giver. When that happens, the easiest
      # way to fix things is to just re-do the entire list
      redo ASSIGN_RECIPIENTS if ! defined $recipient;

      %results{$giver} = $recipient;
      %available_recipients{$recipient}:delete;
    }
    last; # exit the labelled loop
  }
  return %results;
}

sub solution(@names) {
  say "Input: \@names = ('"
    ~ @names.join("',\n                 '")
    ~ "')";
  my %recipients = secretSanta(@names);
  say "Output:";
  for @names -> $giver {
    say "    $giver -> %recipients{$giver}";
  }
}

say "Example 1:";
solution(['Mr. Wall', 'Mrs. Wall', 'Mr. Anwar',
          'Mrs. Anwar', 'Mr. Conway', 'Mr. Cross']);

say "\nExample 2:";
solution(['Mr. Wall', 'Mrs. Wall', 'Mr. Anwar']);
