#!/usr/bin/env raku
use v6;
sub MAIN {
   my @accounts =
      ['A', 'a1@a.com', 'a2@a.com'],
      ['B', 'b1@b.com'],
      ['A', 'a3@a.com', 'a4@a.com'],
      ['B', 'b2@b.com', 'b1@b.com'],
      ['A', 'a8@a.com'],
      ['A', 'a3@a.com', 'a2@a.com'],
   ;

   for merge-accounts(@accounts) -> $merged {
      put '[', $merged.map({"'$_'"}).join(', '), ']';
   }
}

sub merge-accounts (@accounts) {
   my %alternatives_for;
   for @accounts -> $account {
      my ($name, @addresses) = @$account;
      my $new = { name => $name, addresses => @addresses.Set };

      my @disjoint;
      my $all = %alternatives_for{$name} //= [];
      for @$all -> $candidate {
         if ($new<addresses> ∩ $candidate<addresses>) { # merge
            $new<addresses> = (
               $new<addresses>.keys.Slip,
               $candidate<addresses>.keys.Slip
            ).Set;
         }
         else {
            @disjoint.push: $candidate;
         }
      }
      @disjoint.push: $new;
      %alternatives_for{$name} = @disjoint;
   }
   return %alternatives_for.values».Slip.flat
      .map({[ $_<name>, $_<addresses>.keys.Slip ]})
      .Array;
}
