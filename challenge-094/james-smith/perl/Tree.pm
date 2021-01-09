package Tree;
use LL;
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
