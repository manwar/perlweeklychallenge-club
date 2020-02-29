#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $cache = lru->new(3);
$cache->set(1,3);
$cache->set(2,5);
$cache->set(3,7);
say $cache->get(2);
say $cache->get(1);
say $cache->get(4);
$cache->set(4,9);
say $cache->get(3);

package lru;
sub new {

    my $class = shift;
    #Create a class/package that has
    #Variable object to hold the cache size/capacity
    #Hash object to hold key-value pairs
    #Array object to hold the order of LRU (LRU ... MRU)
    my $self = {
        'size'  => shift,
        'hash'  => {},
        'order' => []
    };
    bless $self, $class;
    return $self;
}

sub set {
    my ($self, $key, $value) = @_;
    
    #Delete LRU from hash and update order if
    #cache is FULL (hash size is equal to cache size)
    if ((!exists ($self->{hash}{$key})) && (~~keys %{$self->{hash}} >= $self->{size})) {
        delete $self->{hash}{$self->{order}[0]};
        shift @{$self->{order}};
    }
    
    #Update order array
    #If the key already exists in cache remove the key from order array then...
    if (exists ($self->{hash}{$key})) {
        @{$self->{order}} = grep  { $_ != $key } @{$self->{order}};
    } 
    
    #put it in last/highest index (Considered as MRU)
    push @{$self->{order}}, $key;

    #Update hash key-value pair
    $self->{hash}{$key} = $value;
}

sub get {
    my ($self, $key) = @_;

    if (exists $self->{hash}{$key}) {
        #Update the order of the array same as the one in Set method
        @{$self->{order}} = grep  { $_ != $key } @{$self->{order}};

        #put it in last/highest index (Considered as MRU)
        push @{$self->{order}}, $key;

        #Return the value of the given key
        return $self->{hash}{$key}
    } else {
        return -1;
    }

}
=begin
perl .\ch-2.pl
5
3
-1
-1
=cut