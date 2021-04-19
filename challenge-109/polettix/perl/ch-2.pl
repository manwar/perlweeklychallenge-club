#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use List::Util 'shuffle';

sub four_squares_puzzle (@values) {
   my $it = permutations_iterator(items => [@values]);
   while (my @S = $it->()) {
      my $sum = $S[0] + $S[1];
      next if $sum != $S[1] + $S[2] + $S[3];
      next if $sum != $S[3] + $S[4] + $S[5];
      next if $sum != $S[5] + $S[6];
      my @keys = 'a' .. 'g';
      my %retval;
      @retval{@keys} = @S;
      return %retval;
   }
   return;
}

my @input = @ARGV == 7 ? @ARGV : 1 .. 7;
my %solution = four_squares_puzzle(shuffle @input);
if (! scalar keys %solution) {
   say 'no solution, sooooorry!';
}
else {
   for my $key (sort keys %solution) {
      say "$key = $solution{$key}";
   }
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
