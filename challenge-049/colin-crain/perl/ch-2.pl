#! /opt/local/bin/perl
#
#    lru_cache.pl
#
#     PWC 49 - TASK #2
#     LRU Cache
#         Write a script to demonstrate LRU Cache feature. It should support
#         operations get and set. Accept the capacity of the LRU Cache as command line
#         argument.
#
#         Definition of LRU: An access to an item is defined as a get or a set
#         operation of the item. “Least recently used” item is the one with the
#         oldest access time.
#
#         For example:
#
#             capacity = 3
#             set(1, 3)
#             set(2, 5)
#             set(3, 7)
#
#             Cache at this point:
#             [Least recently used] 1,2,3 [most recently used]
#
#             get(2)      # returns 5
#
#             Cache looks like now:
#             [Least recently used] 1,3,2 [most recently used]
#
#             get(1)      # returns 3
#
#             Cache looks like now:
#             [Least recently used] 3,2,1 [most recently used]
#
#             get(4)      # returns -1
#
#             Cache unchanged:
#             [Least recently used] 3,2,1 [most recently used]
#
#             set(4, 9)
#
#             Cache is full, so pushes out key = 3:
#             [Least recently used] 2,1,4 [most recently used]
#
#             get(3)      # returns -1
#
#
#     method: unlike many languages, perl has easy access to the internal elements
#         of arrays with splice(). As such the need to build a linked list is
#         lessened. We can access the data itself using a hash, keyed on the label
#         used to identify the cached data. As such that label will need to be
#         safe for using as a hash key, but that functionality is not demonstrated
#         here.
#
#         Alongside the hash for data lookup, we keep a parallel array list
#         containing the label key for a given piece of data that keeps track of
#         insertions like a stack; if this grows larger than our maximum size
#         elements are removed off the bottom as new elements are added to the
#         top. This gives us our LRU functionality. Accessing the data moves the
#         element back to the top of the list, as does setting a given label
#         already present again.
#
#         In this version setting an already existing label with new data is
#         allowed, it is moved to the top and the data replaced.
#
#         Using splice, push and shift to keep track of the eviction list is
#         perhaps a little slower than using a linked list for the job, but this
#         is not a given. If speed is critical, choosing a compiled LRU would make
#         more sense. For many applications, like keeping local copies of foreign
#         server data, or memoizing complicated calculations, this will serve just
#         fine.
#

#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



# use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $size = shift @ARGV;

my $cache = LRU->new($size);

## the above plus a few more variations to demonstrate
$cache->set(1,3);
$cache->set(2,5);
$cache->set(3,7);
$cache->set(2,5);

$cache->get(2);
$cache->get(1);
$cache->get(4);
$cache->set(4,9);
$cache->get(3);
$cache->get(4);


## ## ## ## ## SUBS

package LRU;

sub new {
    my ($class, $size)  = @_;
    my $self    = { "list"      => [],
                    "lookup"    => {},
                    "size"     => $size     };
    bless $self, $class;
    return $self;
}

sub set {
    my ($self, $label, $data) = @_;

    ## if it already exists, bump up its timestamp and update the data
    if (exists $self->{lookup}->{$label} ) {
        $self->{lookup}->{$label} = $data;
        my $idx;
        for ( 1..scalar $self->{list}->@* ) { $idx = $_; last if $self->{list}->[$idx-1] eq $label };
        splice( $self->{list}->@*, $idx-1, 1);
        push $self->{list}->@*, $label;

        say "set($label, $data)   cache is now [", (join ', ',$self->{list}->@*), ']';

        return;
    }

    ## else create and insert at head
    $self->{lookup}->{$label} = $data;
    push $self->{list}->@*, $label;

    ## delete if cache is overfilled
    if (scalar $self->{list}->@* > $self->{size}) {
        my $deleted = shift $self->{list}->@*;
        delete $self->{lookup}->{$deleted};
    }

    ## inspection code left in to demonstrate
    say "set($label, $data)   cache is now [", (join ', ',$self->{list}->@*), ']';
}

sub get {
    my ($self, $label) = @_;

    ## this version returns the literal string "undef" to more clearly
    ## demonstrate the action, rather than undef the undefined value, which in
    ## practice would be preferred. Returning '-1' seems to preclude having that
    ## result for valid data, and seems limiting.
    return "undef" unless exists $self->{lookup}->{$label};

    my $idx;
    for ( 1..scalar $self->{list}->@* ) { $idx = $_; last if $self->{list}->[$idx-1] eq $label };
    splice( $self->{list}->@*, $idx-1, 1);
    push $self->{list}->@*, $label;

    ## inspection code left in to demonstrate
    say "get($label) = $self->{lookup}->{$label}  cache is now [", (join ', ',$self->{list}->@*), "]";

    return $self->{lookup}->{$label};
}
