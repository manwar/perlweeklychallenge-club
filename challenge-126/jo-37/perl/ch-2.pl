#!/usr/bin/perl -s

use v5.16;
use PDL;
use experimental 'signatures';

our $examples;

# Make whichND's default behaviour as in scalar context.
$PDL::whichND = 's';

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [infile]

-examples
    run the examples from the challenge

infile
    file name holding input data.  See __DATA__ section for an example.

EOS


### Input and Output

print_pdl(count_mines(read_pdl(*ARGV)));


### Implementation

# Investigating the neighborhood of a matrix element: This shouts out
# for PDL.

sub count_mines ($m) {
    # Create 3x3 neighborhood matrices around every field and count the
    # mines therein.
    my $c = byte $m->range(ndcoords($m) - 1, 3, 'truncate')
        ->reorder(2, 3, 0, 1)
        ->sumover->sumover;

    # Convert digits to their ascii values.
    $c += ord('0');

    # Set mined fields to 'x'.
    $c->indexND(whichND($m)) .= ord('x');

    $c;
}

# Read rows of 'x's and '*'s representing mined and clear fields and
# gather them in a byte piddle of ones and zeros.
sub read_pdl ($fh) {
    my $p = null;
    while (<$fh>) {
        $p = $p->glue(1, byte tr/x*/10/r);
    }

    $p;
}

# Print a 2-d piddle containing ascii character codes.
sub print_pdl ($p) {
    say "@{[map chr, @$_]}" for @{$p->unpdl};
}


### Examples and tests

sub run_tests {
    print_pdl(count_mines(read_pdl(*DATA)));
    exit;
}


__DATA__
x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x
