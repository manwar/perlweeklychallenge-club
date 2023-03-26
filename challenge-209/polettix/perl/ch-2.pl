#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

use constant TRUE  => (!0);
use constant FALSE => (!!0);

my @accounts = (
   ['A', 'a1@a.com', 'a2@a.com'],
   ['B', 'b1@b.com'],
   ['A', 'a3@a.com', 'a4@a.com'],
   ['B', 'b2@b.com', 'b1@b.com'],
   ['A', 'a8@a.com'],
   ['A', 'a3@a.com', 'a2@a.com'],
);

for my $merged (merge_accounts(\@accounts)->@*) {
   say '[', join(', ', map { +"'$_'"} $merged->@* ), ']';
}

sub hashes_intersect ($h1, $h2) {
   my $n1 = scalar(keys($h1->%*));
   my $n2 = scalar(keys($h2->%*));
   ($h1, $h2) = ($h2, $h1) if $n1 > $n2;

   # now $h1 has *at most* as many elements as $h2, it's beneficial to
   # iterate over it
   for my $key (keys $h1->%*) {
      return TRUE if exists $h2->{$key};
   }
   return FALSE;
}

sub merge_accounts ($aref) {
   my %alternatives_for;  # track each name separately
   my %group_for;         # track aggregated groups by order of appearance
   for my $i (0 .. $aref->$#*) {
      my ($name, @addresses) = $aref->[$i]->@*;
      $group_for{$i} = my $new = {
         i => $i,
         name => $name,
         addresses => { map { $_ => 1 } @addresses },
      };

      # Add this group like it's detached
      my $all_groups = $alternatives_for{$name} //= [];
      push $all_groups->@*, $new;

      # sweep back to merge when necessary
      my $challenger = $all_groups->$#*;
      my $resistant = $challenger - 1;
      my $last_wiped;
      while ($resistant >= 0) {
         my $cas = $all_groups->[$challenger]{addresses};
         my $ras = $all_groups->[$resistant]{addresses};
         if (hashes_intersect($cas, $ras)) {
            $ras->%* = ($ras->%*, $cas->%*);     # merge

            ($last_wiped, $challenger) = ($challenger, $resistant);
            delete $group_for{$all_groups->[$last_wiped]{i}};
            $all_groups->[$last_wiped] = undef;
         }
         --$resistant;
      }

      # sweep ahead to remove wiped out stuff, if necessary
      if (defined($last_wiped)) {
         my $marker = my $cursor = $last_wiped;
         while (++$cursor < $all_groups->$#*) {
            next if defined($all_groups->[$cursor]);
            $all_groups->[$marker++] = $all_groups->[$cursor];
         }
         splice $all_groups->@*, $marker if $marker < $all_groups->@*;
      }
   }

   my @accounts = map {
      my $group = $group_for{$_};
      [ $group->{name}, sort { $a cmp $b } keys $group->{addresses}->%* ];
   } sort { $a <=> $b } keys %group_for;

   return \@accounts;
}
