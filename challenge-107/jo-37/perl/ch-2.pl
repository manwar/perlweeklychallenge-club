#!/usr/bin/perl -s -T

use v5.16;
use Test2::V0;
use lib '.';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [package...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

package...
    "require"s <package> and lists the subs therein.
    Call "$0 Calc" for the task's example.

EOS


### Input and Output

for (@ARGV) {
    # Untaint input.  Allow "::" and "'" as package separators.
    next unless /^( (?&PKG) (?: (?: :: | ' ) (?&PKG) )* )$
        (?(DEFINE) (?<PKG> [_[:alpha:]] [[:word:]]*))/x;
    my $package = $1;

    eval "require $package";
    die $@ if $@;

    say "\n$package:";
    say for sort @{list_methods($package)};
}


### Implementation

# Not a solution, but an approximation:
#
# Inspecting the package's symbol table to solve the task, though this
# approach cannot lead to a proper solution.  The five specially named
# code blocks "BEGIN" etc. have an empty CODE slot in their symbol
# table's entry.  This makes them indistinguishable from any other entry
# *not* referencing a sub.  Specifically, an undefined but used
# package-global scalar-only variable looks exactly the same.  See
# example "Foo".
# For the sake of simplicity assuming the existence of a special block
# if there is a symbol table entry with such a name.  This may lead to
# false positives if a variable or a format with the name of a special
# block is in use.  Heuristics based on the content of other slots would
# make things even worse: In addition to the inevitable false positives
# this would produce false negatives.
#
sub list_methods {
    # Get a reference to the package's symbol table.  Using a symbolic
    # ref to simplify matters.
    my $symtab = do {no strict 'refs'; *{shift . '::'}{HASH}};

    [grep {
        *{$symtab->{$_}}{CODE} || /^(?:BEGIN|UNITCHECK|CHECK|INIT|END)$/;
    } keys %{$symtab}];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        require Calc;
        is list_methods('Calc'), bag {item 'BEGIN'; item 'mul';
            item 'div'; item 'new'; item 'add'; end},
            'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        is list_methods('Foo::Bar'),
            bag {item 'foo_bar'; item 'INIT'; end},
            'every possible slot is in use';

        is list_methods('Foo'), bag {item 'foo'; item 'BEGIN'; end},
            'false positive';
	}

    done_testing;
    exit;
}


package Foo::Bar;

sub foo_bar {}
our @array;
our %hash;
INIT {
    our $scalar = 1;
    *FH = *STDIN{IO};
}
() = *FH;
format FORMAT =
. 


package Foo;

sub foo {}
our $BEGIN;
