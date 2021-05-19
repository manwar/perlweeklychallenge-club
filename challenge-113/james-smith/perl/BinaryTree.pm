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

sub walk {
  my( $self, $fn, $global, $local, $dir ) = @_;
  $local = $fn->( $self, $global, $local, $dir||'' );
  $self->left->walk(  $fn, $global, $local, 'left'  ) if $self->has_left;
  $self->right->walk( $fn, $global, $local, 'right' ) if $self->has_right;
  return;
}

sub flatten {
  my( $self,$dump_fn ) = @_;
  $dump_fn ||= sub { $_[0] };
  my $arrayref = [];
  $self->walk( sub {
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
