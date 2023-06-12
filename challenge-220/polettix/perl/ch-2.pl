#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
use JSON::PP;

my $sit = squareful_iterator(@ARGV);
while (my $squareful = $sit->()) {
   say encode_json($squareful) =~ tr{[]}{()}r;
}

sub squareful_iterator (@ints) {
   return sub { return undef } if @ints < 2;
   my $it = permutations_iterator(items => \@ints);
   my %seen;
   return sub {
      while (my $candidate = $it->()) {
         next unless is_squareful($candidate);
         return $candidate unless $seen{join ',', $candidate->@*}++;
      }
      return;
   };
}

sub is_squareful ($list) {
   for my $i (1 .. $list->$#*) {
      my $sum = $list->[$i - 1] + $list->[$i];
      return 0 if int(sqrt($sum)) ** 2 != $sum;
   }
   return 1;
}

sub permutations_iterator {
   my %args = (@_ && ref($_[0])) ? %{$_[0]} : @_;
   my $items = $args{items} || die "invalid or missing parameter 'items'";
   my $filter = $args{filter} || sub { wantarray ? @_ : [@_] };
   my @indexes = 0 .. $#$items;
   my @stack = (0) x @indexes;
   my $sp = undef;
   return sub {
      if (! defined $sp) { $sp = 0 }
      else {
         while ($sp < @indexes) {
            if ($stack[$sp] < $sp) {
               my $other = $sp % 2 ? $stack[$sp] : 0;
               @indexes[$sp, $other] = @indexes[$other, $sp];
               $stack[$sp]++;
               $sp = 0;
               last;
            }
            else {
               $stack[$sp++] = 0;
            }
         }
      }
      return $filter->(@{$items}[@indexes]) if $sp < @indexes;
      return;
   }
}
