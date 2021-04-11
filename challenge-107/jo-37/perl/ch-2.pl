#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'uniq';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [package...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

package...
    list subs provided by <package> 
    Call "$0 Calc" for the task's example.

EOS


### Input and Output

for (@ARGV) {
    say "\n$_:";
    say for sort @{list_methods($_)};
}


### Implementation

# B::Concise reports all subs including the special blocks BEGIN etc.
# when called with
# -stash=<pgk>,BEGIN,...
# But it reports B::Concise's BEGIN blocks, too.  So these need to be
# identified and skipped.  There's a "nextstate" entry following a
# special block entry identifying the package it belongs to.  

sub list_methods {
    my $pkg = shift;
    # The names of special blocks.
    my @specials = qw(BEGIN UNITCHECK CHECK INIT END);
    # The same as a regexp.
    my $special_re = sub {local $" = '|'; qr(@_)}->(@specials);

    # Suppress "syntax OK" written to STDERR.
    no warnings 'once';
    open STDERR_SAVE, '>&2' or die 'cannot duplicate STDERR';
    close STDERR;

    my @meth;
    my $concise;
    {
        local $" = ',';
        open $concise, '-|',
           "$^X -Mlib=. -MO=Concise,-stash=$pkg,@specials -e ''"
            or die 'cannot open Concise pipe';
    }

    my $special;
    while (<$concise>) {
        # Forget special block on entry to the next block/sub.
        undef $special if /^(?:$special_re|FUNC)/;
        # Found a sub inside the package.
        push @meth, $1 if /^FUNC: \*${pkg}::(\w+)/;
        # Found a special block.
        $special = $1 if /^($special_re)\s/;
        # Special block belongs to the package.
        push @meth, $special if $special && /<;> nextstate\($pkg/;
    }
    close $concise;
    open STDERR, '>&STDERR_SAVE' or die 'cannot restore STDERR';

    [uniq @meth];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is list_methods('Calc'), bag {item 'BEGIN'; item 'mul';
            item 'div'; item 'new'; item 'add'; end},
            'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        is list_methods('Foo::Bar'),
            bag {item 'foo_bar'; item 'INIT'; end},
            'every possible slot is in use';

        is list_methods('Foo'), bag {item 'foo'; item 'bar'; end},
            'no special block';
	}

    done_testing;
    exit;
}
