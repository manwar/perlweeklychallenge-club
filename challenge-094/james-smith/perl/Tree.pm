package Tree;
use LL;

## The tree is stored in an array ref
# The first element is the value of the node
# The remainder of the array are child sub-trees
#
# Methods:
#  ->add_child( $child_tree )
#  ->to_ll( $list )           -- convert tree into linked lit ( if list is
#                                passed then they are added to the end of this list )
#  ->flatten                  -- flatten list to array.
#

sub new {
  my $class = shift;
  my $value = shift;
  my $self = [ $value ];
  bless $self, $class;
}

sub add_child {
  my( $self,$child ) = @_;
  push @{$self}, $child;
  return $self;
}

sub to_ll {
  my( $self, $ll ) = @_;
  my ($v,@sub) = @{$self};
  unless( $ll ) {
    $ll = LL->new( $v );
  } else {
    $ll->add( $v );
  }
  $_->to_ll($ll) foreach @sub;
  return $ll;
}

sub flatten {
  my $self = shift;
  my ($v,@sub) = @{$self};
  return ( $v, map { $_->flatten } @sub );
}

1;
