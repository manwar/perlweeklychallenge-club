#!/usr/bin/env perl

use v5.38;
use Data::Dumper::Concise;

sub isExactChangePossible {
  my @bills = @_;
  my %till; # we keep the bills in a "till"
  BILLS: foreach my $collected ( @bills ) {
    # put the bill we collected in the "till"
    $till{$collected}++;

    # calculate the required change
    my $change_required = $collected - 5;

    # if we don't need to make change,
    # skip to the next bill collected!
    next BILLS unless $change_required;

    # loop through the bills we have on hand
    # in descending size (try to make change
    # with the largest bills possible)
    foreach my $bill ( reverse sort { $a <=> $b } keys %till ) {

      # as long as we have more of this bill and
      # using it would not yield TOO MUCH change
      while ( $till{$bill} > 0 && $change_required - $bill >= 0 ) {
        # deduct the amount from the required change
        $change_required -= $bill;

        # remove the bill from the till
        $till{$bill}--;
      }

      # move on if we managed to make exact change!
      next BILLS unless $change_required;
    }

    # if we weren't able to make change, fail
    return 0 if $change_required;
  }

  # we successfully made change for all transactions!
  return 1;
}

sub solution {
  my @bills = @_;
  say 'Input: @bills = (' . join(', ', @bills) . ')';
  my $output = isExactChangePossible(@bills);
  say 'Output: ' . ($output ? 'true' : 'false');
}

say "Example 1:";
solution(5, 5, 5, 10, 20);

say "\nExample 2:";
solution(5, 5, 10, 10, 20);

say "\nExample 3:";
solution(5, 5, 5, 20);