#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

use Data::Dumper;

my @routes = ([1,2,3], [4,5,6], [3,8,9], [7,8]);
my $source = 1;
my $destination = 7;
my $route = shortest_route(\@routes, $source, $destination) // [];
{ local $" = ','; say $route->@* ? "($route->@*)" : -1 }

sub shortest_route ($routes, $src, $dst) {
   my $graph = routes_to_graph($routes);
   return scalar astar(
      start => $src,
      goal  => $dst,
      distance => sub { return 1 },
      successors => sub ($v) { keys $graph->{$v}->%* },
      identifier => sub ($v) { $v },
   );
}

sub routes_to_graph ($routes) {
   my %adjacents_for;
   for my $route ($routes->@*) {
      my $prev = $route->[0];
      for my $i (1 .. $route->$#*) {
         my $curr = $route->[$i];
         $adjacents_for{$prev}{$curr} = $adjacents_for{$curr}{$prev} = 1;
         $prev = $curr;
      }
   }
   return \%adjacents_for;
}

sub astar {
   my %args = (@_ && ref($_[0])) ? %{$_[0]} : @_;
   my @reqs = qw< start goal distance successors >;
   exists($args{$_}) || die "missing parameter '$_'" for @reqs;
   my ($start, $goal, $dist, $succs) = @args{@reqs};
   my $h     = $args{heuristic}  || $dist;
   my $id_of = $args{identifier} || sub { return "$_[0]" };

   my ($id, $gid) = ($id_of->($start), $id_of->($goal));
   my %node_for = ($id => {value => $start, g => 0});
   my $queue = bless ['-', {id => $id, f => 0}], __PACKAGE__;

   while (!$queue->_is_empty) {
      my $cid = $queue->_dequeue->{id};
      my $cx  = $node_for{$cid};
      next if $cx->{visited}++;

      my $cv = $cx->{value};
      return __unroll($cx, \%node_for) if $cid eq $gid;

      for my $sv ($succs->($cv)) {
         my $sid = $id_of->($sv);
         my $sx = $node_for{$sid} ||= {value => $sv};
         next if $sx->{visited};
         my $g = $cx->{g} + $dist->($cv, $sv);
         next if defined($sx->{g}) && ($g >= $sx->{g});
         @{$sx}{qw< p g >} = ($cid, $g);    # p: id of best "previous"
         $queue->_enqueue({id => $sid, f => $g + $h->($sv, $goal)});
      } ## end for my $sv ($succs->($cv...))
   } ## end while (!$queue->_is_empty)

   return;
} ## end sub astar

sub _dequeue {                              # includes "sink"
   my ($k, $self) = (1, @_);
   my $r = ($#$self > 1) ? (splice @$self, 1, 1, pop @$self) : pop @$self;
   while ((my $j = $k * 2) <= $#$self) {
      ++$j if ($j < $#$self) && ($self->[$j + 1]{f} < $self->[$j]{f});
      last if $self->[$k]{f} < $self->[$j]{f};
      (@{$self}[$j, $k], $k) = (@{$self}[$k, $j], $j);
   }
   return $r;
} ## end sub _dequeue

sub _enqueue {                              # includes "swim"
   my ($self, $node) = @_;
   push @$self, $node;
   my $k = $#$self;
   (@{$self}[$k / 2, $k], $k) = (@{$self}[$k, $k / 2], int($k / 2))
     while ($k > 1) && ($self->[$k]{f} < $self->[$k / 2]{f});
} ## end sub _enqueue

sub _is_empty { return !$#{$_[0]} }

sub __unroll {    # unroll the path from start to goal
   my ($node, $node_for, @path) = ($_[0], $_[1], $_[0]{value});
   while (defined(my $p = $node->{p})) {
      $node = $node_for->{$p};
      unshift @path, $node->{value};
   }
   return wantarray ? @path : \@path;
} ## end sub __unroll
