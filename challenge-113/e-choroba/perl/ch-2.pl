#! /usr/bin/perl
use warnings;
use strict;

{   package Node;
    use Moo;
    has value      => (is => 'rw', required => 1);
    has leftchild  => (is => 'rw', predicate => 1);
    has rightchild => (is => 'rw', predicate => 1);

    sub walk {
        my ($self, $sub) = @_;
        $self->leftchild->walk($sub)  if $self->has_leftchild;
        $self->rightchild->walk($sub) if $self->has_rightchild;
        $sub->($self);
    }
}

my $seven = 'Node'->new(value => 7);
my $four  = 'Node'->new(value => 4, leftchild => $seven);
my $two   = 'Node'->new(value => 2, leftchild => $four);
my $five  = 'Node'->new(value => 5);
my $six   = 'Node'->new(value => 6);
my $three = 'Node'->new(value => 3, leftchild => $five, rightchild => $six);
my $one   = 'Node'->new(value => 1, leftchild => $two,  rightchild => $three);

my $sum;
$one->walk(sub { $sum += $_[0]->value});

$one->walk(sub { $_[0]->value($sum - $_[0]->value) });

use Test::More tests => 7;
is $one->value,   27;
is $two->value,   26;
is $three->value, 25;
is $four->value,  24;
is $five->value,  23;
is $six->value,   22;
is $seven->value, 21;
