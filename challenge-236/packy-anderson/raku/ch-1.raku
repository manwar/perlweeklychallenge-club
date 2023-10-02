#!/usr/bin/env raku

use v6;

sub isExactChangePossible(*@bills where ($_.all ~~ Int)) {
  my %till; # we keep the bills in a "till"
  BILLS: for @bills -> $collected {
    # put the bill we collected in the "till"
    %till{$collected}++;

    # calculate the required change
    my $change_required = $collected - 5;

    # if we don't need to make change,
    # skip to the next bill collected!
    next BILLS unless $change_required;

    # loop through the bills we have on hand
    for %till.keys().sort({ .Int }).reverse() -> $bill {
      # as long as we have more of this bill and
      # using it would not yield TOO MUCH change
      while ( %till{$bill} > 0 && $change_required - $bill >= 0 ) {
        # deduct the amount from the required change
        $change_required -= $bill;

        # remove the bill from the till
        %till{$bill}--;
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
  say 'Input: @bills = (' ~ @bills.join(', ') ~ ')';
  my $output = isExactChangePossible(@bills);
  say 'Output: ' ~ ($output ?? 'true' !! 'false');
}

say "Example 1:";
solution(5, 5, 5, 10, 20);

say "\nExample 2:";
solution(5, 5, 10, 10, 20);

say "\nExample 3:";
solution(5, 5, 5, 20);
