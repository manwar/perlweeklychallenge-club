#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'reduce';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [PATH...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

PATH...
    paths to be examined

EOS


### Input and Output

say common_base_dir(@ARGV);


### Implementation

# The example seams to be easy, but a closer look uncovers some issues:
# - The result in the example does not end in a slash.  However, this
#   cannot not affect the leading slash.  A common root path still
#   consists of a single slash.
# - The given paths may not be canonical.  As the canonicalization was
#   already solved in week 112, I'll take the given paths as canonical.
# - All paths in the example end in a file name.  What if the final
#   file part is empty and the path ends in a slash?  I'm going to
#   distinguish these cases with /a/b and /a/b/c having /a as the
#   common base directory whereas /a/b/ and /a/b/c having /a/b in
#   common.
# - Though a trailing slash is not wanted in the final result, it needs
#   to be present in the matching process.  Otherwise partial directory
#   name matches could give false results.

sub common_base_dir {
    # Remove a trailing (possibly empty) file part, concatenate the two
    # elements inside the "reduce" block with a NULL character in
    # between (it cannot be part of a file path) and match the maximum
    # common path from the beginning of both elements.  Take the common
    # path as the new reduction.  Finally remove a slash from the result
    # if it is not the single starting slash.
    # NB1: Here a path is a string starting with a slash followed by
    # zero or more nonempty directory names followed by a slash.
    # NB2: Using "\N{NULL}" here instead of the shorter "\0" to make it
    # clear that this is something completely different from "\1".
    (reduce {
            "$a\N{NULL}$b" =~ m{^(/(?:[^/]+/)*).*?\N{NULL}\1}s;
            $1;
        } map {s{/\K[^/]*$}{}r} @_
    ) =~ s{(?<!^)/$}{}r;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is common_base_dir(qw(/a/b/c/1/x.pl /a/b/c/d/e/2/x.pl
            /a/b/c/d/3/x.pl /a/b/c/4/x.pl /a/b/c/d/5/x.pl)),
        '/a/b/c', 'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        is common_base_dir(qw(/a /b)), '/', 'common root';
        is common_base_dir(qw(/a/b/c /a/b)), '/a', 'no trailing slahses';
        is common_base_dir(qw(/a/b/c /a/b/)), '/a/b', 'empty file name';
        is common_base_dir(qw(/ab/ /ac/)), '/', 'partial name match';
        is common_base_dir("/a/b\nc", "/a/b"), '/a', 'newline in filename';
        is common_base_dir("/xy/a\nb/c", "/xy/a\nc/d"), "/xy",
            'newline in dirname';
        is common_base_dir("/xy/a\nb/c", "/xy/a\nb/c"), "/xy/a\nb",
            'newline in common dirname';
	}

    done_testing;
    exit;
}
