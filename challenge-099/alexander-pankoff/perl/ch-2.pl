#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

{
    if ( $ENV{TESTING} ) {
        test_count_subsequences();
    }
    else {
        my ( $S, $T ) = @ARGV;
        die "usage: $0 STRING STRING\n" unless @ARGV == 2;

        say count_subsequences( $S, $T );
    }
}

sub test_count_subsequences() {

    my @test_cases = ( [ "littleit", "lit", 5 ], [ "london", "lon", 3 ], );

    require Test::More;
    Test::More->import( tests => scalar @test_cases );

    for my $test (@test_cases) {
        my ( $string, $target, $count ) = @{$test};
        ok(
            count_subsequences( $string, $target ) == $count,
            "$string contains $count subsequences matching $target"
        );
    }
}

# This implementation was done after reading @jacoby 's blog where he explains
# his solution.  You can find the blog and a decent explanation of the
# recursive process here:
# https://jacoby.github.io/2021/02/11/london-patterns-perl-weekly-challenge-99.html
# To add something new to his idea I have added the StringIterator class to
# handle the position tracking.
sub count_subsequences ( $string, $target ) {

    # create a recurisve helper routine that works on StringIterator objects
    my $go;
    $go = sub ( $string_iterator, $target_iterator ) {
        my $current = $string_iterator->next;

        # we're at the end of the string
        return 0 if !defined $current;

        # recurse into the non matching case. here we have to clone our
        # iterators to prevent modifications inside of the nested calls from
        # affecting us here
        # the $string_iterator has already been advanced by our call to next
        # whereas the target_iterator is still in its original state
        my $count = $go->( $string_iterator->clone, $target_iterator->clone );

        # advance the target_iterator and get the current target char
        my $target_char = $target_iterator->next;
        if ( $current eq $target_char ) {

            # we have a full match if the target_iterator is exhausted. We can
            # increment the count and stop here.
            if ( $target_iterator->is_at_end ) {
                $count += 1;
            }

            # if we don't have a full match we have to recurse. both iterators
            # have been advanced by now and won't be used anymore. we can pass
            # them as is.
            else {
                $count += $go->( $string_iterator, $target_iterator, );
            }
        }

        return $count;
    };

    # create the Iterator objects and go!
    $go->( StringIterator->new($string), StringIterator->new($target) );
}

package StringIterator {

    sub new ( $class, $string ) {
        my $self = {
            string   => $string,
            position => 0,
            size     => length($string),
        };

        return bless $self, $class;
    }

    # returns the current char and advances the iterator
    # returns `undef` if the iterator is exhausted
    sub next($self) {
        return undef if $self->is_at_end();
        my $char = substr( $self->{string}, $self->{position}, 1 );
        $self->{position}++;
        return $char;
    }

    # returns 1 if the iterator is at the end
    #         0 otherwise
    sub is_at_end($self) {
        return 1 if $self->{position} >= $self->{size};
        return 0;
    }

    # returns a clone of the iterator object
    sub clone($self) {
        return bless {%$self}, ref $self;
    }
}

