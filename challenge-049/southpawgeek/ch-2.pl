#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my $cap = 3;
($cap) = @ARGV if @ARGV;
die "$cap isn't an int! \n" if $cap =~ /\D/;

say "ok, capacity set to $cap";

my @keys;
my %cache;

set(1,3);
set(2,5);
set(3,7);
say get(2), "\n";
say get(1), "\n";
say get(4), "\n";
set(4,9);
say get(3), "\n";
set(5,11);
say get(2), "\n";

sub set{
    my ($key, $val) = @_;

    # remove oldest element if we're full
    if (scalar @keys >= $cap) {
        my $discard = shift @keys if scalar @keys >= $cap;
        say "discarded oldest cache data with key $discard";
        delete $cache{$discard};      
    }

    # push returns number of elements, so subtract 1
    my $index = (push @keys, $key) - 1;

    # populate the cache
    $cache{$key} = {'value' => $val, 'index' => $index};
    say "added $key, $val at index $index";

    say "LRU @keys MRU\n";
}

sub get{
    my $key = shift;
    say "getting value for key $key...";

    my $val = $cache{$key}->{'value'} || undef;
    say "$key isn't there" and return -1 unless $val;

    my $index = $cache{$key}->{'index'};
    say "found $key, $val at index $index";

    my $removed = splice @keys, $index, 1;
    say "removed $removed from index $index";

    push @keys, $key;

    # this will be number of elements - 1 unless something has gone wrong
    $index = scalar @keys - 1;
    say "MRU key $key is now indexed at $index";

    # also update the cache index
    $cache{$key}->{'index'} = $index;
    
    say "LRU @keys MRU";
    return $val;
}