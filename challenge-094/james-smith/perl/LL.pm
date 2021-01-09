package LL;

# The linked list object consists of 3 values;
#  * 'val'  => the value of the node;
#  * 'next' => the next node in the list;
#  * 'last' => the last node in the list; {so can easily add next value}

# Two methods:
#  * ->add( $val ) => Add another value to the end of the list
#  * ->flatten     => Flatten to array of values

sub new {
  my $class = shift;
  my $self = { 'val' => shift, 'next' => undef };
  $self->{'last'} = $self;
  bless $self, $class;
}

sub add {
  my( $self, $val ) =@_;
  my $new = LL->new( $val );
  $self->{'last'}{'next'} = $new;
  $self->{'last'} = $new;
  return $self;
}

sub flatten {
  my $self = shift;
  return $self->{'val'} unless $self->{'next'};
  return ( $self->{'val'}, $self->{'next'}->flatten );
}

1;
