#       HistoryThing
#
#       object
#
#
#       (c) 2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

package HistoryThing;

use Moo;
use feature ":5.26";
our $VERSION = "0.01";


## attributes
has 'x' => (
    is => 'rw',
    trigger => sub {
        my ($self, $new) = @_;
        push $self->_history->{'x'}->@*, $new;
    }
);

has 'y' => (
    is => 'rw',
    trigger => sub {
        my ($self, $new) = @_;
        push $self->_history->{'y'}->@*, $new;
    }
);

## pubic methods
sub get_hist {
    my ($self, $var) = @_;
    return (join ', ', $self->_history->{$var}->@*);

};

## private attribute (hash)
has _history => (
    is => 'rw',
    default => sub {
        return { 'x' => [], 'y' => [] };
    },
);


1;
