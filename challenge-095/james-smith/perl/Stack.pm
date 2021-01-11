package Stack;

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
  my $self = [];
  bless $self, $class;
}

sub push {
  my( $self,$val ) = @_;
  push @{$self}, $val;
  return $self;
}

sub pop {
  my $self = shift;
  return unless @{$self};
  return CORE::pop(@{$self});
}

sub top {
  my $self = shift;
  return unless @{$self};
  return $self->[-1];
}

sub min {
  my $self = shift;
  return unless @{$self};
  my $min = $self->[0];
  foreach (@{$self}) {
    $min = $_ if $_ < $min;
  }
  return $min;
}

1;
