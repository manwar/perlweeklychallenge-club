#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [WORD...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

WORD...
    list of words

EOS


### Input and Output

main: {
    my $prefixes = unique_prefix('', [@ARGV], []);
    # To bring the prefixes into the original word order, each word is
    # matched against all prefixes and the suffixes are dropped.
    my $match = do {local $" = '|'; qr/@$prefixes/};
    say join ' ', map s/^(?:$match)\K.*//r, @ARGV;
}


### Implementation

# Taking a list of word suffixes for a common prefix and distribute
# these onto a hash having the common prefix followed by the first
# letter of the suffix as keys.  All newly created prefixes having only
# one suffix are unique.  Recursively find the unique prefixes for the
# remaining words.  The unique prefixes are returned in random order.
sub unique_prefix ($prefix, $words, $uniq) {
	my %prefix;
    for my $word (@$words) {
        my $first = substr $word, 0, 1, '';
        push $prefix{$prefix . $first}->@*, $word;
    }
    for my $p (keys %prefix) {
        if ($prefix{$p}->@* == 1) {
            push @$uniq, $p;
        } else {
            unique_prefix($p, $prefix{$p}, $uniq);
        }
    }
    $uniq;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is unique_prefix('', [qw(alphabet book carpet cadmium cadeau alpine)],
            []),
        bag {
            item 'alph'; item 'b'; item 'car'; item 'cadm'; item
            'cade'; item 'alpi'; end;
        }, 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
