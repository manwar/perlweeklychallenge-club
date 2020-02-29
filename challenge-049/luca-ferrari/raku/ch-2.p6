#!env raku
#
# Perl Weekly Challenge 49
# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-049/>
#
# Task 2
# LRU Cache
#
# Write a script to demonstrate LRU Cache feature.
# It should support operations get and set.
# Accept the capacity of the LRU Cache as command line argument.
#
# Definition of LRU: An access to an item is defined as a get or a set operation of the item.
# “Least recently used” item is the one with the oldest access time.
#
#  For example:
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
# Cache is full, so pushes out key = 3:
#                                                                                                               # [Least recently used] 2,1,4 [most recently used]
#
# get(3)      # returns -1
#


# Example of invocation
#
#
#
# % raku ch-2.p6
#
# [Capacity: 3]
# [Least Recently Used] -->>>     1 (used 3 times)        2 (used 5 times)        3 (used 7 times) <<<-- [Most Recently Used]
#
# get( 2 ) = 5
#
# [Capacity: 3]
# [Least Recently Used] -->>>     1 (used 3 times)        3 (used 7 times)        2 (used 6 times) <<<-- [Most Recently Used]
#
# get( 1 ) = 3
#
# [Capacity: 3]
# [Least Recently Used] -->>>     3 (used 7 times)        2 (used 6 times)        1 (used 4 times) <<<-- [Most Recently Used]
#
# get( 4 ) = -1
#
# [Capacity: 3]
# [Least Recently Used] -->>>     3 (used 7 times)        2 (used 6 times)        1 (used 4 times) <<<-- [Most Recently Used]
#
#
# [Capacity: 3]
# [Least Recently Used] -->>>     2 (used 6 times)        1 (used 4 times)        4 (used 9 times) <<<-- [Most Recently Used]
#
# get( 3 ) = -1
#
# [Capacity: 3]
# [Least Recently Used] -->>>     2 (used 6 times)        1 (used 4 times)        4 (used 9 times) <<<-- [Most Recently Used]





class LRU {
    # contains a list of Pairs (not an hash!)
    # where every pair has the value of times it has been used
    # and every key is the number
    has Pair @!values;
    has Int $.capacity;


    method get( Int $what ) {
        # find the first $what value and see where it is within the
        # array
        my ( Int $where, Pair $pair ) = @!values.first: { .key == $what }, :kv;

        # not found
        return -1 if ! $pair;

        # now remove the element from the array and
        # insert it on the right incremented
        @!values.splice( $where, 1 );
        @!values.append: $pair.key => $pair.value + 1;

        # here $pair still holds the old value
        return $pair.value;
    }

    # Is the cache full?
    method !is-full() { return @!values.elems >= $!capacity; }

    # remove the least recently used value, always the one on the left
    method !make-space() { @!values.splice( 0, 1 ); }

    method set( Int $value, Int $how-many-times ) {
        # make some space if the cache is full
        self!make-space() if self!is-full;
        @!values.push: $value => $how-many-times;
    }


    method Str() {
        my $string = "\n[Capacity: {$!capacity}]\n[Least Recently Used] -->>>";
        $string = "%s\t%d (used %d times)".sprintf( $string, $_.key, $_.value)  for @!values;
        $string ~= " <<<-- [Most Recently Used]\n";
        return $string;
    }
}



sub MAIN( Int :$capacity  where { $capacity > 0 } = 3 ) {

    my $lru = LRU.new: capacity => $capacity;
    $lru.set(1, 3);
    $lru.set(2, 5);
    $lru.set(3, 7);
    $lru.put;

    my @gets = 2,1,4;
    for @gets {
        say "get( {$_} ) = { $lru.get( $_ )}";
        $lru.put;
    }


    $lru.set(4,9);
    $lru.put;

    say "get( 3 ) = { $lru.get( 3 )}";
    $lru.put;

}
