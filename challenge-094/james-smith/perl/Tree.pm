package Tree;

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

sub flatten {
  my $self = shift;
  my ($v,@sub) = @{$self};
  return ( $v, map { $_->flatten } @sub );
}

1;
