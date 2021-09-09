#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use Data::Dumper;

my $target = shift || 2;

{
   my $n2 = node(2, node(4, node(6, map {node($_)} (8, 9))));
   my $n3 = node(3, node(5, node(7)));
   my $root = node(1, $n2, $n3);
   local $Data::Dumper::Indent = 1;
   say Dumper($root);
   say depth($root, $target);
}


sub node ($l, @c) { return {label => $l, children => \@c} }

sub depth ($root, $label) {
   my $depth = 0;
   eval {
      depth_first_visit(
         start => $root,
         successors => sub ($n) { ($n->{children} // [])->@* },
         identifier => sub ($n) { $n->{label} },
         pre_action => sub ($n, $parent) {
            die 'done!' if $n->{label} eq $label;
            ++$depth;
         },
         post_action => sub { --$depth },
      );
      1;
   } or return $depth;
   return 'NaN';
}

sub depth_first_visit {
   my %args = (@_ && ref($_[0])) ? %{$_[0]} : @_;
   my @reqs = qw< start successors >;
   exists($args{$_}) || die "missing parameter '$_'" for @reqs;
   my ($start, $succs) = @args{@reqs};
   my $id_of = $args{identifier} || sub { return "$_[0]" };
   my $pre_action  = $args{pre_action} || undef;
   my $post_action = $args{post_action} || undef;
   my $skip_action = $args{skip_action} || undef;
   my %adjacents = ($id_of->($start) => [$succs->($start)]);
   my @stack = ([$start, undef]);
   $pre_action->($start, undef) if $pre_action;
   while (@stack) {
      my ($v, $pred) = @{$stack[-1]}; # "peek"
      my $vid = $id_of->($v);
      if (@{$adjacents{$vid}}) {
         my $w = shift @{$adjacents{$vid}};
         my $wid = $id_of->($w);
         if (exists $adjacents{$wid}) { # already visited
            $skip_action->($w, $v) if $skip_action;
         }
         else {                         # new node to be visited
            $adjacents{$wid} = [$succs->($w)];
            push @stack, [$w, $v];
            $pre_action->($w, $v) if $pre_action;
         }
      }
      else {
         $post_action->($v, $pred) if $post_action;
         pop @stack;
      } # finished with this frame
   }
   return unless defined wantarray; # don't bother with void context
   return keys %adjacents if wantarray;
   return [keys %adjacents] if defined wantarray;
}
