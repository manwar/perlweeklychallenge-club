
#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub int_sums_iterator ($N, $max = undef) {
   if ($N < 1) {
      my @retvals = ([]);
      return sub { shift @retvals };
   }
   $max //= $N;
   my $first = $N < $max ? $N : $max;
   my $rit   = undef;
   return sub {
      my @retval;
      while ($first > 0) {
         $rit //= int_sums_iterator($N - $first, $first);
         if (my $rest = $rit->()) {
            return [$first, $rest->@*];
         }
         ($first, $rit) = ($first - 1, undef);
      }
      return;
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

sub basketball_points ($S) {
   # $isi keeps track of iterating through all partitions of the
   # input integer $S with 1, 2, or 3
   my $isi = int_sums_iterator($S, 3);

   # $pi allows iterating through all partitions of a specific
   # partition of $S. %seen allows filtering out duplicates.
   my ($pi, %seen);

   return sub {
      while ('necessary') {
         if (!$pi) { # no more permutations? Start next cycle
            # if $isi->() does not return anything meaningful, we
            # exhausted the partitions of $S and can stop here.
            my $arrangement = $isi->() or return;

            # otherwise, $pi will help us move through the
            # permutations
            $pi = permutations_iterator(items => $arrangement);
            %seen = ();
         }
         if (my @candidate = $pi->()) {
            # %seen is used to filter out duplicates. As a hash, it
            # is indexed via a string, which is $key in our case
            my $key = join ' ', @candidate;
            return @candidate unless $seen{$key}++;

            # if $seen[$key} was already greater than 0 we arrive here.
            # The external loop "while ('necessary')..." takes care
            # to move on to the next candidate
         }
         else {
            # we arrive here if the permutations iterator is exhausted.
            # We set $pi to undef, so that the test at the beginning
            # of the loop will generate a new permutations iterator.
            $pi = undef;
         }
      }
   };
}

my $total = shift || 5;
my $bp = basketball_points($total);
while (my @s = $bp->()) {
   say join ' ', @s;
}
