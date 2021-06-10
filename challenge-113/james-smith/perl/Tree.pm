package Tree;

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
  my $self = [ $value ];
  bless $self, $class;
}

sub add_child {
  my( $self,$child ) = @_;
  push @{$self}, $child;
  return $self;
}

sub walk {
  my( $self, $fn, $data, $t ) = @_;
  my ($v,@sub) = @{$self};
  $t = $fn->( $self, $data, $t );
  $_->walk( $fn, $data, $t ) foreach @sub;
  return;
}

sub flatten {
  my $self = shift;
  my ($v,@sub) = @{$self};
  return ( $v, map { $_->flatten } @sub );
}

1;
