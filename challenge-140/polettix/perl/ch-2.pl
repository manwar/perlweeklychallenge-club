#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my ($i, $j, $k) = @ARGV;
$i //= 2;
$j //= 3;
$k //= 4;

say multiplication_table_pq($i, $j, $k);
say multiplication_table_bf($i, $j, $k) if $k < 2000;

sub multiplication_table_bf ($i, $j, $k) {
   my @prods;
   for my $I (1 .. min($i, $k)) {
      for my $J (1 .. min($j, $k)) {
         push @prods, $I * $J;
      }
   }
   @prods = sort {$a <=> $b} @prods;
   return $prods[$k - 1];
}

sub max ($x, $y) { $x > $y ? $x : $y }
sub min ($x, $y) { $x < $y ? $x : $y }

sub multiplication_table_pq ($i, $j, $k) {
   die "out of range (too low!)\n" if $k == 0;
   die "out of range (too high!)\n" if $k > $i * $j;

   return $k if $k <= 2 || $k == $i * $j;
   return max($i * ($j - 1), ($i - 1) * $j) if $k == $i * $j - 1;

   my $pq = BPQ->new(
      before => sub ($x, $y) { $x->[0] < $y->[0] },
      items  => [[1, 1, 1]],
   );
   my %seen = ('1.1' => 1); # just to give the gist of it...
   while ($k > 1) {
      my ($p, $I, $J) = $pq->dequeue->@*;
      for my $deltas ([0, 1], [1, 0]) {
         my $I_ = $I + $deltas->[0];
         next if $I_ > $i;
         my $J_ = $J + $deltas->[1];
         next if $J_ > $j;
         next if $seen{"$I_.$J_"}++;
         $pq->enqueue([$I_ * $J_, $I_, $J_]);
      }
      --$k;
   }
   my ($result) = $pq->dequeue->@*;
   return $result;
}

package BPQ;
sub dequeue;    # see below
sub enqueue;    # see below
sub is_empty    { return !$#{$_[0]{items}} }
sub top         { return $#{$_[0]{items}} ? $_[0]{items}[1] : () }
sub new;        # see below
sub size        { return $#{$_[0]{items}} }

sub dequeue {    # includes "sink"
   my ($is, $before, $k) = (@{$_[0]}{qw< items before >}, 1);
   return unless $#$is;
   my $r = ($#$is > 1) ? (splice @$is, 1, 1, pop @$is) : pop @$is;
   while ((my $j = $k * 2) <= $#$is) {
      ++$j if ($j < $#$is) && $before->($is->[$j + 1], $is->[$j]);
      last if $before->($is->[$k], $is->[$j]);
      (@{$is}[$j, $k], $k) = (@{$is}[$k, $j], $j);
   }
   return $r;
} ## end sub dequeue

sub enqueue {    # includes "swim"
   my ($is, $before) = (@{$_[0]}{qw< items before >});
   push @$is, $_[1];
   my $k = $#$is;
   (@{$is}[$k / 2, $k], $k) = (@{$is}[$k, $k / 2], int($k / 2))
     while ($k > 1) && $before->($is->[$k], $is->[$k / 2]);
} ## end sub enqueue

sub new {
   my $package = shift;
   my $self = bless {((@_ && ref($_[0])) ? %{$_[0]} : @_)}, $package;
   $self->{before} ||= sub { $_[0] < $_[1] };
   (my $is, $self->{items}) = ($self->{items} || [], ['-']);
   $self->enqueue($_) for @$is;
   return $self;
} ## end sub new
1;
