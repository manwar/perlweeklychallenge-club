#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [path...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

path...
    path name(s)

EOS


### Input and Output

say c_path($_) // "path not valid: $_" for @ARGV;


### Implementation

# - Remove leading slashes or give up.
# - Split the path into parts delimited by (possibly multiple) slashes.
# - Reverse the parts.
#
# - Increment the skip count if the current part is '..' and suppress
#   the current part.
# - Suppress the current part if it is '.' or the skip count is positive
#   (decrementing it).
# - Pass the current part otherwise.
#
# - Reverse the parts.
# - Give up if the skip count is still positive after all parts have
#   been processed.
# - Prepend an empty part to produce a leading slash.
# - Provide an empty part if the given path resolves to the
#   root path i.e. it has no parts.
# - Join the parts with slashes.
sub c_path {
    local $_ = shift;
    s{^/+}{} or return;

    my $skip;
    my @part = reverse grep {
        /^\.\.\z/ ? !++$skip : /^\.\z/ || $skip && $skip-- ? 0 : 1;
    } reverse split m{/+};

    $skip ? undef : join '/', '', @part, ('') x !@part;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is c_path('/a/'), '/a', 'example 1';
        is c_path('/a/b//c/'), '/a/b/c', 'example 2';
        is c_path("/a/b/c/../.."), '/a', 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is c_path('a'), U(), 'not an absolute path';
        is c_path('/a/../..'), U(), 'ascend beyond root';
        is c_path('/a/b/../././../c'), '/c', 'mixed dots';
        is c_path('/../'), U(), 'ascend from root';
        is c_path('/0/../1'), '/1', 'accept "0"';
        is c_path('/a/.//b/'), '/a/b', 'skip current dir';
        is c_path('/.a/.b/'), '/.a/.b', 'dot names';
        is c_path('/a/.../b/'), '/a/.../b', 'three dots';
        is c_path('/'), '/', 'root';
        is c_path('///'), '/', 'repeated root';
        is c_path("\n/a"), U(), 'leading newline part';
        is c_path("/a/\n/b"), "/a/\n/b", 'embedded newline part';
        is c_path("/a/\n"), "/a/\n", 'trailing newline part';
        is c_path("/a/b\nc/d"), "/a/b\nc/d", 'embedded newline';
        is c_path("/a/\n./b"), "/a/\n./b", 'newline before dot';
        is c_path("/a/.\n/b"), "/a/.\n/b", 'newline after dot';
        is c_path("/a/\n../b"), "/a/\n../b", 'newline before two dots';
        is c_path("/a/..\n/b"), "/a/..\n/b", 'newline after two dots';
	}

    done_testing;
    exit;
}
