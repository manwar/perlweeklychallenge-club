#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my @array = @ARGV ? @ARGV : qw< 2 1 2 1 1 > ;
my $ad = array_degree(\@array);
{local $" = ', '; say "($ad->@*)"}

sub array_degree ($array) {
   my %data_for;
   my @letter_for = ({});
   for my $i (0 .. $array->$#*) {
      my $item = $array->[$i];
      my $data = $data_for{$item} //= { start => $i, count => 0 };
      $data->{stop} = $i;
      $data->{length} = 1 + $i - $data->{start};
      delete $letter_for[$data->{count}++]{$item};
      $letter_for[$data->{count}]{$item} = $data;
   }
   my ($best) = sort { $a->{length} <=> $b->{length} }
      values $letter_for[-1]->%*;
   return [$array->@[$best->{start} .. $best->{stop}]];
}
