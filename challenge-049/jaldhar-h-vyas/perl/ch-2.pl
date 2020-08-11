#!/usr/bin/perl

package Data::LRUCache;
use Moo;
use namespace::clean;

has _cache => (
    is => 'rw',
    default => sub { [] }
);

has _index => (
    is => 'rw',
    default => sub { {} }
);

has _capacity => (
    is => 'ro',
);

sub BUILDARGS {
    my ($orig, $class, @args) = @_;

    return { _capacity => $args[0] };
};

sub get {
    my ($self, $key) = @_;

    if (!grep { $_ == $key } @{ $self->{_cache} }) {
        return -1;
    }
    @{ $self->{_cache} } = grep { $_ != $key } @{ $self->{_cache} };
    unshift @{ $self->{_cache}}, $key;
    return $self->{_index}->{$key};
}

sub set {
    my ($self, $key, $value) = @_;

    if (scalar @{ $self->{_cache} } == $self->{_capacity}) {
        my $last = pop @{ $self->{_cache} };
        delete $self->{_index}->{$last};
    }
    unshift @{ $self->{_cache} }, $key;
    $self->{_index}->{$key} = $value;
}

sub print() {
    my ($self) = @_;

    for my $e (@{ $self->{_cache} }) {
        print "$e => ", $self->{_index}->{$e}, "\n";
    }
}

1;

package main;
use warnings;
use strict;
use 5.010;

my $capacity = shift // 3;

my $cache = Data::LRUCache->new(capacity => $capacity);

$cache->set(1, 3);
$cache->set(2, 5);
$cache->set(3, 7);
$cache->print;
say $cache->get(2);
$cache->print;
say $cache->get(1);
$cache->print;
say $cache->get(4);
$cache->print;
$cache->set(4, 9);
$cache->print;
say $cache->get(3);
