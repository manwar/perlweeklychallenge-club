#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'postderef';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [ARR ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

ARR ...
    Arrays to be zipped.  Each array's elements are separated by comma.

EOS


sub zip (\@\@;\@\@\@\@\@\@);


### Input and Output

# Cannot call the prototyped sub with a variable number of arguments.
# Convert undefined values to the string 'undef'.
# See examples and tests for calls complying with the task description.
say "@{[map $_ // 'undef', &zip(map [split /,/, $_], @ARGV)]}";


### Implementation

# There are two major strategies about how to zip a list of arrays:
# - Take the minimum length of all given arrays and ignore elements
#   beyond that position in longer arrays.
# - Take the maximum length of all given arrays and fill shorter arrays
#   with 'undef'.
# Another way would be:
# - Take the length of the first array and fill/truncate the remaining
#   arrays.
# When all arrays have the same size, these variants produce the same
# result.  For the sake of convenience choosing the third way.
#
# I'm not going to use any of the implementations available from several
# modules.  What comes to mind are:
# - List::Util::zip 
# - List::MoreUtils::zip
# - List::Gen::zip
# - List::Gen::zipmax
#
# Adopting List::MoreUtils::zip's prototype
# \@\@;\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@\@
# to a maximum of eight given arrays.
#
sub zip (\@\@;\@\@\@\@\@\@) {
    # For each of the first array's indices build a list of elements
    # from all given arrays at the selected index and concatenate these.
    map {my $i = $_; (map $_->[$i], @_)} 0 .. $_[0]->$#*;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my @a = qw/1 2 3/;
        my @b = qw/a b c/;

        is [zip(@a, @b)], [qw/1 a 2 b 3 c/], 'example 1';
        is [zip(@b, @a)], [qw/a 1 b 2 c 3/], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        my @a = qw(a b c);
        my @b = qw(1 2);
        my @c = qw(A B C D);

        is [zip(@a, @b, @c)], ['a', 1, 'A', 'b', 2, 'B', 'c', undef, 'C'],
        'three different sizes';
	}

    done_testing;
    exit;
}
