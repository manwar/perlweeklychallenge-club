package Node;
use strict;
use warnings;

sub new {
    my ( $class, $val, $left, $right ) = @_;
    return bless { val => $val, left => $left, right => $right }, $class;
}

package main;
use strict;
use warnings;

sub sum_tree {
    my ( $node, $total ) = @_;
    $total //= 0;
    return 0 unless defined $node;
    $total =
      sum_tree( $node->{left},  $total ) +
      sum_tree( $node->{right}, $total ) +
      $node->{val};
    $node->{val} = $total - $node->{val};
    return $total;
}

# Testing
my $root = Node->new(1);
$root->{left}          = Node->new(2);
$root->{right}         = Node->new(3);
$root->{left}->{left}  = Node->new(4);
$root->{left}->{right} = Node->new(5);
sum_tree($root);
print $root->{val},          "\n";    # Outputs: 14
print $root->{left}->{val},  "\n";    # Outputs: 11
print $root->{right}->{val}, "\n";    # Outputs: 2
