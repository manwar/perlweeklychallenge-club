package LL;

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
