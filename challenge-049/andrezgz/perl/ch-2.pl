#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-049/
# Task #2
#
# LRU Cache
# Write a script to demonstrate LRU Cache feature.
# It should support operations get and set.
# Accept the capacity of the LRU Cache as command line argument.
#
# Definition of LRU: An access to an item is defined as a get or
# a set operation of the item.
# "Least recently used" item is the one with the oldest access time.
#
# For example:
#
# capacity = 3
# set(1, 3)
# set(2, 5)
# set(3, 7)
#
# Cache at this point:
# [Least recently used] 1,2,3 [most recently used]
#
# get(2)      # returns 5
#
# Cache looks like now:
# [Least recently used] 1,3,2 [most recently used]
#
# get(1)      # returns 3
#
# Cache looks like now:
# [Least recently used] 3,2,1 [most recently used]
#
# get(4)      # returns -1
#
# Cache unchanged:
# [Least recently used] 3,2,1 [most recently used]
#
# set(4, 9)
#
# Cache is full, so pushes out key = 3:
# [Least recently used] 2,1,4 [most recently used]
#
# get(3)      # returns -1
#
# I found this amazing post talking about LRU Cache.
# https://www.interviewcake.com/concept/java/lru-cache

use strict;
use warnings;

my $c = shift or die "USAGE: $0 <capacity>";
die "Capacity of the LRU Cache must be a positive number" unless ( $c =~ /\d+/ && $c > 0);

print "Capacity = $c\n\n";

my @lru = ();
my %cache = ();

set(1, 3);
set(2, 5);
set(3, 7);
get(2);
get(1);
get(4);
set(4, 9);
get(3);


sub set {
    my ($k, $v) = @_;

    print "set($k, $v)\n\n";

    push @lru, $k;

    if (@lru > $c) {
        my $out = shift @lru;
        delete $cache{$out};
        print "Cache is full: pushed out key = $out\n";
    }
    else {
        print "Cache updated:\n";
    }

    $cache{$k} = $v;

    show(@lru);
}

sub get {
    my ($k) = @_;

    print "get($k)\t-> returns ";

    if (exists $cache{$k}) {
         print "$cache{$k}\n\nCache updated:\n";
         @lru = grep { $_ != $k } @lru;
         push @lru,$k;
    }
    else {
        print "-1\n\nCache unchanged:\n";
    }

    show(@lru);

}

sub show {
    my @lru = @_;
    print '[Least recently used] ';
    print join ',',@lru;
    print " [most recently used]\n\n";
}

__END__

./ch-2.pl 2
Capacity = 2

set(1, 3)

Cache updated:
[Least recently used] 1 [most recently used]

set(2, 5)

Cache updated:
[Least recently used] 1,2 [most recently used]

set(3, 7)

Cache is full: pushed out key = 1
[Least recently used] 2,3 [most recently used]

get(2)  -> returns 5

Cache updated:
[Least recently used] 3,2 [most recently used]

get(1)  -> returns -1

Cache unchanged:
[Least recently used] 3,2 [most recently used]

get(4)  -> returns -1

Cache unchanged:
[Least recently used] 3,2 [most recently used]

set(4, 9)

Cache is full: pushed out key = 3
[Least recently used] 2,4 [most recently used]

get(3)  -> returns -1

Cache unchanged:
[Least recently used] 2,4 [most recently used]
