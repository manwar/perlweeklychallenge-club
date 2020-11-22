#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use autodie;

main(shift);

sub main ($filename = undef) {
   my $fh =
       !defined $filename ? \*DATA
     : $filename eq '-'   ? \*STDIN
     :                      do { open my $fh, '<', $filename; $fh };
   my @matrix;
   while (<$fh>) {
      my @row = split m{\s+};
      push @matrix, \@row;
      shift @row;    # "["
      pop @row;      # "]"
   } ## end while (<$fh>)
   if (my $lr = largest_rectangle(\@matrix)) {
      my ($rs, $rl, $cs, $cl) = $lr->@*;
      local $, = ' ';
      say {*STDOUT} '[', $matrix[$_]->@[$cs .. $cs + $cl - 1], ']'
        for $rs .. $rs + $rl - 1;
   } ## end if (my $lr = largest_rectangle...)
   else {
      say {*STDOUT} 0;
   }
} ## end sub main ($filename = undef)

sub largest_rectangle ($M) {
   my $rows = $M->@* or return;
   my $cols = $M->[0]->@* or return;
   my $mpq = PriorityQueue->new(before => sub {$_[0]{size} > $_[1]{size}});
   $mpq->enqueue({rows => $rows, cols => $cols, size => $rows * $cols});
   my %have_done; # this avoids double searching the same rows x columns
   while (! $mpq->is_empty) {
      my ($rl, $cl) = $mpq->dequeue->@{qw< rows cols >};
      for my $rs (0 .. $rows - $rl) {
         for my $cs (0 .. $cols - $cl) {
            my @candidate = ($rs, $rl, $cs, $cl);
            return \@candidate if is_full_rectangle($M, @candidate);
         }
      }

      # insert further candidates, if possible
      for my $delta ([-1, 0], [0, -1]) {
         my ($rn, $cn) = ($rl + $delta->[0], $cl + $delta->[1]);
         next unless $rn * $cn > 1; # no 1x1 apparently!
         if ($have_done{"$rn-$cn"}) {
            delete $have_done{"$rn-$cn"}; # spare some memory...
         }
         else {
            $have_done{"$rn-$cn"} = 1;
            $mpq->enqueue({rows => $rn, cols => $cn, size => $rn * $cn});
         }
      }
   }
   return; # found nothing, apparently!
}

sub is_full_rectangle ($M, $rs, $rl, $cs, $cl) {
   for my $r ($rs .. $rs + $rl - 1) {
      my $Mr = $M->[$r];
      for my $c ($cs .. $cs + $cl - 1) {
         return unless $Mr->[$c];
      }
   }
   return 1;
}

package PriorityQueue;  # Adapted from https://algs4.cs.princeton.edu/24pq/
use strict;

sub contains    { return $_[0]->contains_id($_[0]{id_of}->($_[1])) }
sub contains_id { return exists $_[0]{item_of}{$_[1]} }
sub is_empty    { return !$#{$_[0]{items}} }
sub item_of { exists($_[0]{item_of}{$_[1]}) ? $_[0]{item_of}{$_[1]} : () }
sub new;                # see below
sub dequeue { return $_[0]->_remove_kth(1) }
sub enqueue;                # see below
sub remove    { return $_[0]->remove_id($_[0]{id_of}->($_[1])) }
sub remove_id { return $_[0]->_remove_kth($_[0]{pos_of}{$_[1]}) }
sub size      { return $#{$_[0]{items}} }
sub top       { return $_[0]->size ? $_[0]{items}[1] : () }
sub top_id    { return $_[0]->size ? $_[0]{id_of}->($_[0]{items}[1]) : () }

sub new {
   my $package = shift;
   my $self = bless {((@_ && ref($_[0])) ? %{$_[0]} : @_)}, $package;
   $self->{before} ||= sub { return $_[0] < $_[1] };
   $self->{id_of} ||= sub { return ref($_[0]) ? "$_[0]" : $_[0] };
   my $items = $self->{items} || [];
   @{$self}{qw< items pos_of item_of >} = (['-'], {}, {});
   $self->enqueue($_) for @$items;
   return $self;
} ## end sub new

sub enqueue {    # insert + update in one... DWIM
   my ($is, $id) = ($_[0]{items}, $_[0]{id_of}->($_[1]));
   $_[0]{item_of}{$id} = $_[1];    # keep track of this item
   my $k = $_[0]{pos_of}{$id} ||= do { push @$is, $_[1]; $#$is };
   $_[0]->_adjust($k);
   return $id;
} ## end sub enqueue

sub _adjust {                      # assumption: $k <= $#$is
   my ($is, $before, $self, $k) = (@{$_[0]}{qw< items before >}, @_);
   $k = $self->_swap(int($k / 2), $k)
     while ($k > 1) && $before->($is->[$k], $is->[$k / 2]);
   while ((my $j = $k * 2) <= $#$is) {
      ++$j if ($j < $#$is) && $before->($is->[$j + 1], $is->[$j]);
      last if $before->($is->[$k], $is->[$j]);    # parent is OK
      $k = $self->_swap($j, $k);
   }
   return $self;
} ## end sub _adjust

sub _remove_kth {
   my ($is, $self, $k) = ($_[0]{items}, @_);
   die 'no such item' if (!defined $k) || ($k <= 0) || ($k > $#$is);
   $self->_swap($k, $#$is);
   my $r = CORE::pop @$is;
   $self->_adjust($k) if $k <= $#$is;    # no adjust for last element
   my $id = $self->{id_of}->($r);
   delete $self->{$_}{$id} for qw< item_of pos_of >;
   return $r;
} ## end sub _remove_kth

sub _swap {
   my ($self,  $i,      $j)     = @_;
   my ($items, $pos_of, $id_of) = @{$self}{qw< items pos_of id_of >};
   my ($I, $J) = @{$items}[$i, $j] = @{$items}[$j, $i];
   @{$pos_of}{($id_of->($I), $id_of->($J))} = ($i, $j);
   return $i;
} ## end sub _swap

1;

package main;

__DATA__
[ 0 0 0 1 0 0 ]
[ 1 1 1 0 0 0 ]
[ 0 0 1 0 0 1 ]
[ 1 1 1 1 1 0 ]
[ 1 1 1 1 1 0 ]
