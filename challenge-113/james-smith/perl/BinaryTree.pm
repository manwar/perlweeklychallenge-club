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
  my ($v,$l,$r) = @{$self};
  $local = $fn->( $self, $global, $local, $dir||'' );
  $l->walk( $fn, $global, $local, 'left' ) if defined $l;
  $r->walk( $fn, $global, $local, 'right' ) if defined $r;
  return;
}

sub flatten {
  my( $self,$dump_fn ) = @_;
  $dump_fn ||= sub { $_[0] };
  my $arrayref = [];
  $self->walk( sub {
    my($node,$global) = @_;
    push @{$global}, $dump_fn->( $node->[0] );
  }, $arrayref );
  return @{$arrayref};
}

sub dump {
  my( $self, $dump_fn ) = @_;
  $dump_fn ||= sub { $_[0] };
  $self->walk( sub {
    my( $node, $global, $local, $dir ) = @_;
    say join '', $local||'', $dir eq 'left' ? '<' : $dir eq 'right' ? '>' : ' ', ' ', $dump_fn->($node->[0]);
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
      my $child = BinaryTree->new( $clone_fn->( $node->[0] ) );
      $dir eq 'left' ? $local->add_child_left( $child ) : $local->add_child_right( $child );
      return $child;
    }
    $global->{'tree'} = BinaryTree->new( $clone_fn->( $node->[0] ) );
    return $global->{'tree'};
  }, $clone );
  return $clone->{'tree'};
}

1;
