#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min);

sub common_characters{
  my @letters;
  map{my %h; $h{$_}++ for split ''; push @letters,\%h} @{$_[0]};
  map{my $letter = $_;
      my $rep = min map{$letters[$_]{$letter} // 0} 0..$#letters;
      ($letter) x $rep
    } keys %{$letters[0]};
}

printf "(%s)\n", join ',',
  common_characters([qw/java javascript julia/]);
printf "(%s)\n", join ',',
  common_characters([qw/bella label roller/]);
printf "(%s)\n", join ',', common_characters([qw/cool lock cook/]);

