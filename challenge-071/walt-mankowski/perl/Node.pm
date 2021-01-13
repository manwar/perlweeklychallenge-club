package Node;

use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

sub new($package, $val) {
    my $self = {};
    bless $self, $package;

    $self->{val} = $val;
    $self->{next} = undef;

    return $self;
}

sub set_next($self, $node) {
    $self->{next} = $node;
}

sub next($self) {
    return $self->{next};
}

sub val($self) {
    return $self->{val};
}

1;
