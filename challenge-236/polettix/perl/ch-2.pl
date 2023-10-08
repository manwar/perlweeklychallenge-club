#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say array_loops(map { split m{\D+}mxs } @ARGV);

sub array_loops (@ints) {
   my $uf = UnionFind->new(components => [0 .. $#ints]);
   $uf->union($_, $ints[$_]) for 0 .. $#ints;
   return $uf->count;
}


package UnionFind; # Sedgewick & Wayne, Algorithms 4th ed, §1.5
use strict;

sub add;    # see below
sub connected { return $_[0]->find($_[1]) eq $_[0]->find($_[2]) }
sub count     { return $_[0]{count} }
sub find      { return $_[0]{cs}{$_[0]->find_id($_[1])}[1] }
sub find_id;    # see below
sub new;        # see below
sub union;      # see below

sub add {
   my $id = $_[0]{id_of}->($_[1]);
   return $_[0] if $_[0]{cs}{$id};
   $_[0]{cs}{$id} = [$id, $_[1], 1];
   $_[0]{count}++;
   return $_[0];
}

sub find_id {
   my $r = my $i = $_[0]{id_of}->($_[1]);
   return unless exists $_[0]{cs}{$r};
   $r = $_[0]{cs}{$r}[0] while $r ne $_[0]{cs}{$r}[0];
   ($i, $_[0]{cs}{$i}) = ($_[0]{cs}{$i}[0], $_[0]{cs}{$r}) while $i ne $r;
   return $r;
} ## end sub find_id

sub new {
   my ($pk, %args) = (@_ > 0 && ref($_[1])) ? ($_[0], %{$_[1]}) : @_;
   my $id_of = $args{identifier} || sub { return "$_[0]" };
   my $self = bless {id_of => $id_of, count => 0}, $pk;
   $self->add($_) for @{$args{components} || []};
   return $self;
} ## end sub new

sub union {
   my ($i, $j) = ($_[0]->find_id($_[1]), $_[0]->find_id($_[2]));
   return $_[0] if $i eq $j;
   ($i, $j) = ($j, $i) if $_[0]{cs}{$i}[2] < $_[0]{cs}{$j}[2];   # i -> max
   $_[0]{cs}{$i}[2] += $_[0]{cs}{$j}[2];
   $_[0]{cs}{$j} = $_[0]{cs}{$i};
   $_[0]{count}--;
   return $_[0];
} ## end sub union
