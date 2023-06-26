#!/usr/bin/perl
use strict;
use warnings;

package LinkedList {
    use Class::Tiny qw(value next);

    sub add {
        my ($self, $other) = @_;
        my $carry = 0;
        my $head = my $tail = LinkedList->new;
        while ($self or $other or $carry) {
            my $sum = ($self ? $self->value : 0) + ($other ? $other->value : 0) + $carry;
            $tail->next(LinkedList->new(value => $sum % 10));
            $tail = $tail->next;
            $carry = int($sum / 10);
            $self = $self->next if $self;
            $other = $other->next if $other;
        }
        return $head->next;
    }

    sub to_string {
        my $self = shift;
        my $str = '';
        while ($self) {
            $str .= $self->value . ' -> ';
            $self = $self->next;
        }
        $str =~ s/ -> $//;
        return $str;
    }
};

my $l1 = LinkedList->new(value => 1, next => LinkedList->new(value => 2, next => LinkedList->new(value => 3)));
my $l2 = LinkedList->new(value => 3, next => LinkedList->new(value => 2, next => LinkedList->new(value => 1)));

my $result = $l1->add($l2);
print $result->to_string(), "\n";

