package Stack;

## The stack is just stored as a blessed array.
#
# Methods:
#  ->push( $value ) -- push value on top of stack (return stack itself)
#  ->pop( $value )  -- take value off top of stack & return it
#                      (if stack has no entries return undef/empty value)
#  ->top( $value )  -- returns the value at the top of the stack
#                      (if stack has no entries return undef/empty value)
#  ->min( $value )  -- returns the smallest value in the stack
#                      (if stack has no entries return undef/empty value)


sub new {
  my $class = shift;
  my $self = [];
  bless $self, $class;
  return $self;
}

sub push {
  my( $self,$val ) = @_;
  CORE::push @{$self}, $val; ## Make clear we are using the core push method
  return $self;
}

sub pop {
  my $self = shift;
  return unless @{$self};
  return CORE::pop(@{$self}); ## Make clear we are using the core pop method
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
