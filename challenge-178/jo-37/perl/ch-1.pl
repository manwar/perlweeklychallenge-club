#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Utils 'ceil';
use Math::Complex;
use List::MoreUtils qw(zip part);
use experimental 'signatures';

our ($tests, $examples, $fromqi);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-fromqi] [--] [RE [IM] | CPLX | QI]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-fromqi
    convert a quater-imaginary string into a complex number

RE
    real part of a number in decimal notation.

IM 
    imaginary part of a number in decimal notation

CPLX
    complex number in the form 'a+bi'.

QI
    string representing a quater-imaginary number with an optional
    1-digit broken part. Requires '-fromqi'.

EOS


### Input and Output

say $fromqi ? qi2cplx(shift) : cplx2qi(cplx(@ARGV));


### Implementation

# The task states: "convert a given number (base 10)".  The kind of
# number is not specified.  As quater-imaginary numbers serve to
# represent complex numbers, here a complex number is expected.  In
# general this might be any complex number but for the sake of
# convenience only integer parts are converted into the quater-imaginary
# representation.  Unfortunately, these do not always map to "integer"
# quater-imaginary numbers because odd imaginary parts result in a
# broken place on the quater-imaginary side.  Therefore one broken place
# is allowed for the reverse conversion, too.
#
# Basic conversion algorithms:
#
# To quater-imaginary:
# - convert the real and half the imaginary part of a given complex
#   number to negaquaternary.  This gives one broken place for odd
#   imaginary parts.
# - interleave the negaquternary digits from both parts.
#
# From quater-imaginary:
# - split the digits at even and odd index positions into two parts.
# - convert both parts from negaquaternary to integer
# - double the imaginary part and construct a complex number from these
#   parts.
#
# See also:
# https://en.wikipedia.org/wiki/Negative_base
# https://oeis.org/wiki/Quater-imaginary_base

# Get the quater-imaginary representation of a complex number from its
# integer real and imaginary parts.
sub cplx2qi ($z) {
    my ($re, $im) = map int, $z->Re, $z->Im;
    return 0 unless $re || $im;
    # Get the reversed negaquaternary representation for the real part.
    my $renq = int2rnq($re);
    # We need the reversed negaquaterny representation of the imaginary
    # part divided by two.  This may be obtained by converting the value
    # multiplied by minus two and then taking the last digit as a broken
    # place.
    my $imnq = int2rnq($im * -2);

    # As the real and imaginary parts are reversed, these are aligned at
    # their least significant digit and thus may easily be zipped
    # together starting with the broken place in the imaginary part.
    # Replace 'undef' with zero in the shorter part, join the resulting
    # digits and reverse them.
    my $qi = reverse join '', map $_ // 0, zip @$imnq, @$renq;

    # Remove a leading zero and a trailing zero broken place and insert a
    # dot in front of a nonzero broken part.
    $qi =~ s/^0?(.*)(.)$/$1 . ($2 ? ".$2" : '')/er
}

# Get a complex number from its quater-imaginary representation with one 
# optional broken place.
sub qi2cplx ($qi) {
    # Check for a valid quater-imaginary format with one optional broken
    # place, capture and remove it.
    die "not a valid quater-imaginary number: $qi\n"
        unless $qi =~ s/^([0-3]*)(?:\.([0-3]))?$/$1/;
    $qi ||= 0;
    my $broken = $2 // 0;

    # Split the digit string into its real and imaginary parts.  The
    # real part gets the even indices.
    my ($renq, $imnq) = do {
        my $i = length($qi);
        part {--$i % 2} split //, $qi;
    };

    # Append the broken place to the imaginary part.
    push @$imnq, $broken;

    # Convert the negaquaternary digits to integers, adjust the
    # imaginary part and create a complex number from these parts.
    cplx(nq2int($renq), nq2int($imnq) / -2);
}

# Get an array ref of reversed negaquarternary digits from an integer.
# This is the usual conversion algorithm but with a base of minus four -
# except the usage of "ceil" instead of "floor".
sub int2rnq ($val) {
    return [0] unless $val;
    my @rnq;
    while ($val) {
        my $q = ceil $val / -4;
        push @rnq, $val + 4 * $q;
        $val = $q;
    }
    \@rnq;
}

# Get an integer from a negaquaternary digit array ref. This is the
# usual conversion algorithm but with a base of minus four.
sub nq2int ($val) {
    my $int = 0;
    while (@$val) {
        $int = $int * -4 + shift @$val
    }
    $int;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is cplx2qi(4 + 0*i), '10300', 'example 1 int -> qi';
        is qi2cplx('10300'), 4, 'example 1 qi -> int';
    }

    SKIP: {
        skip "tests" unless $tests;

        is cplx2qi(cplx(35 + 23*i)),    '121003.2', '#1 from Wiki';
        is cplx2qi(15 + 0*i),           '10103',    '#2  from Wiki';
        is cplx2qi(-15 + 0*i),          '1030001',  '#2  from Wiki';
        is cplx2qi(15*i),               '102000.2', '#3 from Wiki';
        is cplx2qi(-15*i),              '2010.2',   '#4 om Wiki';

        is qi2cplx('33'),               '3+6i',     '#1 from OEIS';
        is qi2cplx('133'),              '-1+6i',    '#2 from OEIS';
        is qi2cplx('233'),              '-5+6i',    '#3 from OEIS';
        is qi2cplx('333'),              '-9+6i',    '#3 from OEIS';

        is cplx2qi(-12 +15*i),          '102300.2', '#4 from OEIS';
        is cplx2qi(-5 + 15*i),          '102203.2', '#5 from OEIS';

        # Around the origin and back:
        is qi2cplx('1'),        '1',        '1';
        is qi2cplx('11.2'),     '1+i',      '1+i';
        is qi2cplx('10.2'),     'i',        'i';
        is qi2cplx('113.2'),    '-1+i',     '-1+i';
        is qi2cplx('103'),      '-1',       '-1';
        is qi2cplx('103.2'),    '-1-i',     '-1-i';
        is qi2cplx('0.2'),      '-i',       '-i';
        is qi2cplx('1.2'),      '1-i',      '1-i';

        is cplx2qi(1 + 0*i),    '1',        '1';
        is cplx2qi(1 + i),      '11.2',     '1+i';
        is cplx2qi(i),          '10.2',     'i';
        is cplx2qi(-1 + i),     '113.2',    '-1+i';
        is cplx2qi(-1 + 0*i),   '103',      '-1';
        is cplx2qi(-1 - i),     '103.2',    '-1-i';
        is cplx2qi(-(i)),       '.2',       '-i';
        is cplx2qi(1 - i),      '1.2',      '1-i';
	}

    done_testing;
    exit;
}
