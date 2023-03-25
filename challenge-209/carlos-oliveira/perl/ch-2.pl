use strict;
use warnings;
use v5.36;

use Test::More;
use List::UtilsBy qw(partition_by sort_by);
use List::Util qw(uniqstr);


sub merge_accounts (@accounts) {
  my @merged_accounts;
  my %partitioned_accounts = partition_by { $_->[0] } @accounts;

  for my $account_name (keys %partitioned_accounts) {
    my @accounts = $partitioned_accounts{$account_name}->@*;
    for (my $i = 0; $i < @accounts; $i++) {
      my $u = $i + 1;
      while ($u < @accounts) {
        my @uniq_merged_emails = uniqstr(@{$accounts[$i]}, @{$accounts[$u]});
        # Consider the name of the account, which was deduplicated above,
        # between the merged emails.
        if (@uniq_merged_emails + 1 == $accounts[$i]->@* + $accounts[$u]->@*) {
          $u++;
          next;
        }
        # Get rid of one of the merged entries.
        # Start iterating again since the entry changed
        # to be sure everything is merged together.
        $accounts[$i] = \@uniq_merged_emails;
        splice @accounts, $u, 1;
        $u = $i + 1;
      }
    }
    push @merged_accounts, @accounts;
  }
  return sort_by { $_->[0] } @merged_accounts;
}

my @result = merge_accounts(
  ['A', 'a1@a.com', 'a2@a.com'],
  ['B', 'b1@b.com'],
  ['A', 'a3@a.com', 'a1@a.com']
);
is_deeply \@result, [
  ['A', 'a1@a.com', 'a2@a.com', 'a3@a.com'],
  ['B', 'b1@b.com']
];

@result = merge_accounts(
  ['A', 'a1@a.com', 'a2@a.com'],
  ['B', 'b1@b.com'],
  ['A', 'a3@a.com'],
  ['B', 'b2@b.com', 'b1@b.com']
);
is_deeply \@result, [
  ['A', 'a1@a.com', 'a2@a.com'],
  ['A', 'a3@a.com'],
  ['B', 'b1@b.com', 'b2@b.com']
];

done_testing;
