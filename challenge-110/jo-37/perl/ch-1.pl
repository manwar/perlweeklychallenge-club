#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [file ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

file ...
    name of input file(s)

EOS


### Input and Output

# perlvar states:
#   passing "\*ARGV" as a parameter to a function that expects a
#   filehandle may not cause your function to automatically read the
#   contents of all the files in @ARGV.
# It seems to work, though.
say for phone_numbers(\*ARGV);


### Implementation

# Search the given filehandle for valid phone numbers according to the
# specified number formats.
# The specification is a bit vague, especially as the example
# '+44 1148820341' does not match the respective format
# '+nn  nnnnnnnnnn'.  Therefore some additional assumptions are made:
# - a fixed international dialing prefix of '00'
# - the country code has exactly 2 digits
# - the national number has exactly 10 digits
# - multiple numbers may appear on the same line
# - a phone number starting with a digit must not follow a digit
# - a phone number must not be followed by a digit
# - the number of blanks between prefix and national number is variable
sub phone_numbers ($fh) {
    my @num;
    while (<$fh>) {
        push @num, /((?:\+\d{2}|\(\d{2}\)|(?<!\d)00\d{2}) +\d{10})(?!\d)/g;
    }

    @num;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        open my $fh, '<', \<<EOS;
            0044 1148820341
             +44 1148820341
              44-11-4882-0341
            (44) 1148820341
              00 1148820341
EOS
        is [phone_numbers($fh)],
            ['0044 1148820341', '+44 1148820341', '(44) 1148820341'],
            'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        open my $fh, '<', \<<EOS;
            x0012 1234567890 0023 2345678901y   # valid pair
            x0034 34567890120045 4567890123y    # forbidden adjacent digits
            x+56  5678901234(67) 6789012345y    # valid pair
            0111 1234567890                     # wrong prefix
            +12  123456789                      # number too short
            (12) 12345678901                    # number too long
EOS
        is [phone_numbers($fh)],
            ['0012 1234567890', '0023 2345678901',
            '+56  5678901234', '(67) 6789012345'],
            'several multiple entries';
	}

    done_testing;
    exit;
}
