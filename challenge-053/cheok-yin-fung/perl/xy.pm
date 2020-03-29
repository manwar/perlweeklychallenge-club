package xy;
use strict;

sub new {
    my ($class) = @_;
    bless{
        _value=> $_[1],
        _x=>$_[2],
        _y=>$_[3],
      }, $class;
}

sub x{ $_[0]->{_x}}
sub y{ $_[0]->{_y}}
sub value{ $_[0]->{_value} }

1;
