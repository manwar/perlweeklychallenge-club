#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [M N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

M N
    interpret numbers M and N as decimals holding binaries and add these.

EOS


### Input and Output

say PWC::BitNumber->new($ARGV[0]) + PWC::BitNumber->new($ARGV[1]);


### Implementation

# Overload addition? Let's have some more fun and overload a wider set
# of integer operators including integer constants (enabled by
# calling import()).
#
# Use scalar references as BitNumber objects.
# - The constructor will interpret its argument as a binary number by
#   taking the digits of the decimal representation as binary "digits".
# - The overloaded numification operator does the reverse by exchanging
#   the bases.
# - Negative BitNumbers are not 2's complement but have a sign instead.
# - Operations between a (scalar) number and a BitNumber are allowed.
# - Dereferencing a BitNumber object reveals its integer value.
# - !!! When integer constant overloading is enabled, decimal numbers
#   need to be specified as strings or floating point numbers !!!
#
#   See tests.

package PWC::BitNumber;

use Math::Prime::Util qw(fromdigits todigits);

### Some helper subs (not methods):

# Retrieve the value of a BitNumber or anything else.
sub _val ($num) {
    ref($num) eq __PACKAGE__ ? $$num : $num;
}

# Get the sign of anything.
sub _sign ($num) {
    _val($num) < 0 ? -1 : 1;
}

# Swap factor: false -> 1, true -> -1
sub _swap ($swap) {
    1 - 2 * !!$swap;
}

###

# Constructor: take decimal digits as binary and retain the sign.
sub new ($, $bn) {
    bless \(_sign($bn) * fromdigits [todigits($bn, 10)], 2);
}

# Enable integer constant overloading in the caller's package.
sub import {
    overload::constant integer => sub ($bn, @) {__PACKAGE__->new($bn)};
}

# Provide some principal integer operators.
use overload
    '+' => sub ($self, $other, $) {
        bless \($$self + _val($other));
    },
    '-' => sub ($self, $other, $swap) {
        bless \(_swap($swap) * ($$self - _val($other)));
    },
    '*' => sub ($self, $other, $) {
        bless \($$self * _val($other));
    },
    '/' => sub ($self, $other, $swap) {
        bless \(int +($$self / _val($other)) ** _swap($swap));
    },
    # returns float
    '**' => sub ($self, $other, $swap) {
        $swap = !!$swap;
        exp log($$self) ** (1 - $swap) * $$self ** $swap *
            log(_val($other)) ** $swap * _val($other) ** (1 - $swap);
    },
    '0+' => sub ($self, $, $) {
        _sign($self) * fromdigits [todigits $$self, 2], 10;
    },
    '<=>' => sub ($self, $other, $swap) {
        _swap($swap) * ($$self <=> _val($other));
    };


### Examples and tests

package main;

# Enable integer constant overloading
BEGIN {
    PWC::BitNumber->import;
}

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is 11 + 1, 100, 'example 1';
        is 101 + 1, 110, 'example 2';
        is 100 + 11, 111, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is ${1111},     15.,    'get integer value';
        is ${-1111},    -15.,   'negative value';
        is 0,           0.,     'zero';
        is 1111 + 1,    10000,  'carry';
        is 1111 + 16.,  11111,  'add scalar';
        is 100 - 1,     11,     '4 - 1 = 3';
        is 111 * 11,    10101,  '7 * 3 = 21';
        is 10101 / 11,  111,    '21 / 3 = 7';
        is 21. / 11,    111,    '21 / 3 = 7';
        is -10. <=> -10, -1.,   '-10 < -2';
        is '123',       123.,   'strings and floats';
        is 101 ** 11,   125.,   '5 ** 3 = 125';

        # The binary digits' range is not limited to 0 and 1.  They are
        # taken as the factor at their corresponding position, e.g.:
        # 123(10) = 1 * 10**2 + 2 * 10**1 + 3 * 10**0
        # ->
        # 1 * 2**2 + 2 * 2**1 + 3 * 2**0 = 11(10) = 1011(2)
        is 123,         1011,   'pseudo binary number';
	}

    done_testing;
    exit;
}
