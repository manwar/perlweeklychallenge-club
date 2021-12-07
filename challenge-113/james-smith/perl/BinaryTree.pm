package BinaryTree;

use strict;
use warnings;
use Data::Dumper qw(Dumper);
use feature qw(say);

## The tree is stored in an array ref
# The first element is the value of the node
# The remainder of the array are child sub-trees
#
# Methods:
#  ->add_child( $child_tree )
#  ->flatten                  -- flatten list to array.
#

sub new {
  my $class = shift;
  my $value = shift;
  my $self = [ $value, undef, undef ];
  bless $self, $class;
}

sub value {
  my $self = shift;
  return $self->[0];
}

sub left {
  my $self = shift;
  return $self->[1];
}

sub right {
  my $self = shift;
  return $self->[2];
}

sub has_left {
  my $self = shift;
  return defined $self->[1];
}

sub has_right {
  my $self = shift;
  return defined $self->[2];
}

sub update {
  my( $self, $val ) = @_;
  $self->[0] = $val;
  return $self;
}

sub add_child_left {
  my( $self,$child ) = @_;
  $self->[1] = $child;
  return $self;
}

sub add_child_right {
  my( $self,$child ) = @_;
  $self->[2] = $child;
  return $self;
}

## Define walk method....
sub walk {
  my $self = shift;
  $self->walk_pre( @_ );
  return;
}

##
## Pre-order walk process node then the left and right sub-trees
##

sub walk_pre {
  my( $self, $fn, $global, $local, $dir ) = @_;
  $local = $fn->( $self, $global, $local, $dir||'' );
  $self->left->walk_pre(  $fn, $global, $local, 'left'  ) if $self->has_left;
  $self->right->walk_pre( $fn, $global, $local, 'right' ) if $self->has_right;
  return;
}

##
## In-order walk process left sub-tree, then the node and finally the right sub-tree
##

sub walk_in {
  my( $self, $fn, $global, $local, $dir ) = @_;
  $self->left->walk_in(  $fn, $global, $local, 'left'  ) if $self->has_left;
  $local = $fn->( $self, $global, $local, $dir||'' );
  $self->right->walk_in( $fn, $global, $local, 'right' ) if $self->has_right;
  return;
}

##
## Reverse-order walk process right sub-tree, then the node and finally the left sub-tree
##

sub walk_reverse {
  my( $self, $fn, $global, $local, $dir ) = @_;
  $self->right->walk_reverse( $fn, $global, $local, 'right' ) if $self->has_right;
  $local = $fn->( $self, $global, $local, $dir||'' );
  $self->left->walk_reverse(  $fn, $global, $local, 'left'  ) if $self->has_left;
  return;
}

##
## Post-order walk the left and right subtrees before processing the node...
##

sub walk_post {
  my( $self, $fn, $global, $local, $dir ) = @_;
  $self->left->walk_post(  $fn, $global, $local, 'left'  ) if $self->has_left;
  $self->right->walk_post( $fn, $global, $local, 'right' ) if $self->has_right;
  $local = $fn->( $self, $global, $local, $dir||'' );
  return;
}

sub flatten {
  my( $self,$dump_fn, $method ) = @_;
  $dump_fn ||= sub { $_[0] };
  $method  = $self->can( 'walk_'.($method||'pre') ) || 'walk';
  my $arrayref = [];
  $self->$method( sub {
    my($node,$global) = @_;
    push @{$global}, $dump_fn->( $node->value );
  }, $arrayref );
  return @{$arrayref};
}

sub dump {
  my( $self, $dump_fn ) = @_;
  $dump_fn ||= sub { $_[0] };
  $self->walk( sub {
    my( $node, $global, $local, $dir ) = @_;
    say join '', $local||'', $dir eq 'left' ? '<' : $dir eq 'right' ? '>' : ' ', ' ', $dump_fn->($node->value);
    return $local .= '  ';
  }, {}, '', '' );
  return;
}

sub clone {
  my( $self, $clone_fn ) = @_;
  $self->walk_post( sub { my ($node, $global, $local, $dir ) = @_
    my $new_node = BinaryTree->new( $clone_fn( $node->value ) );
    $new_node->add_child_left(  $self->left->walk_post(  $node, $global ) ) if $self->has_left;
    $new_node->add_child_right( $self->right->walk_post( $node, $global ) ) if $self->has_right;
    return $new_node;
  });
  return
}
sub clonez {
  my( $self, $clone_fn ) = @_;
  $clone_fn ||= sub { $_[0] };
  my $clone = {};
  $self->walk( sub { my( $node, $global, $local, $dir ) = @_;
    if(exists $global->{'tree'} ) {
      my $child = BinaryTree->new( $clone_fn->( $node->value ) );
      $dir eq 'left' ? $local->add_child_left( $child ) : $local->add_child_right( $child );
      return $child;
    }
    $global->{'tree'} = BinaryTree->new( $clone_fn->( $node->value ) );
    return $global->{'tree'};
  }, $clone );
  return $clone->{'tree'};
}

1;
