#!/usr/bin/env perl

# use strict;
# use warnings;
use utf8;

# TASK #2

# Create a script to demonstrate creating dynamic variable name,
# assign a value to the variable and finally print the variable.
# The variable name would be passed as command line argument.

# because variable set as command-line argument, we:
#   * stick with $ARGV[0], to avoid collisions with user input
#   * use Encode to allow Unicode values
#   * set $ARGV[0] if it isn't assigned

use Encode qw{decode_utf8};
@ARGV = map { decode_utf8( $_, 1 ) } @ARGV;
$ARGV[0] //= 'scratch';

# I can be a literalist
${ $ARGV[0] } = 'a value';

#  and heredocs, because heredocs
print <<"END";

$ARGV[0] = ${ $ARGV[0] }

END

