#!/usr/bin/env raku
use v6;

sub taxAmt($income is copy, @tax) {
  return (0, "") if $income == 0; # special case

  my $last_max = 0;
  my @operations;
  my @subtotals;
  for @tax -> ($max is copy, $rate) {
    # adjust the maximum amount at this rate
    # to be relative to the last rate
    $max -= $last_max;
    # the amount to be taxed at this rate
    my $amt = min($income, $max);
    my $tax = $amt * $rate/100;
    # make sure we display to 100ths place
    # if we hace a non-zero tax amount
    $tax = sprintf '%0.2f', $tax if $tax > 0;
    # save the steps so we can display them at the end
    @operations.push("($amt * $rate/100)");
    @subtotals.push($tax);
    # we've just taxed $amt, so remove it from $income
    $income -= $amt; 
    # adjust the last rate for the next loop
    $last_max += $max;
    # bail if there's no more income
    last if $income <= 0;
  }
  my $total = @subtotals.sum;
  $total = sprintf '%0.2f', $total if $total > 0;
  my $explain = "Total Tax => " ~ @operations.join(' + ') ~ "\n"
              ~ "          => " ~ @subtotals.join(' + ') ~ "\n"
              ~ "          => $total";

  return $total, $explain;
}

sub solution($income, @tax) {
  my @display = @tax.map({ "[" ~ $_.join(',') ~ "]" });
  say "Input: \$income = $income, "
    ~ "\@tax = (" ~ @display.join(', ') ~ ")";
  my ($output, $explain) = taxAmt($income, @tax);
  say "Output: $output\n\n$explain";
}

say "Example 1:";
solution(10, [[3, 50], [7, 10], [12,25]]);

say "\nExample 2:";
solution(2, [[1, 0], [4, 25], [5,50]]);

say "\nExample 3:";
solution(0, [[2, 50],]);
