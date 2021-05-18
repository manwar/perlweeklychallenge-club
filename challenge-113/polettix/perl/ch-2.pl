#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub recreate_binary_tree ($tree) {
   my $sum = 0;
   for my $cb ( # do the same loop with different actions inside
      sub ($n) { $sum += $n->{value} },
      sub ($n) { $n->{value} = $sum - $n->{value} },
     )
   {
      my @queue = ($tree);
      while (@queue) {
         my $node = shift(@queue) // next;
         $cb->($node);
         next unless exists $node->{children};
         push @queue, $node->{children}->@*;
      } ## end while (@queue)
   } ## end for my $cb (sub ($n) { ...})
   return $tree;
} ## end sub recreate_binary_tree ($tree)

sub node ($value, $left = undef, $right = undef) {
   my %retval = (value => $value);
   $retval{children} = [$left, $right]
     if defined($left) || defined($right);
   return \%retval;
} ## end sub node

sub printout ($root, $indent = 0) {
   my $value = defined($root) ? $root->{value} : '';
   say '  ' x $indent, "<$value>";
   printout($_, $indent + 1) for $root->{children}->@*;
}

#     1
#    / \
#   2   3
#  /   / \
# 4   5   6
#  \
#   7
my $T =
  node(1, node(2, node(4, undef, node(7))), node(3, node(5), node(6)));

printout(recreate_binary_tree($T));
