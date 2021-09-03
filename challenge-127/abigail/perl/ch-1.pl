#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

#
# The two sets given each contain unique integers. So, the sets
# are disjoint if and only if their union doesn't contain duplicates.
# An array of integers doesn't contain duplicates if we create a hash
# out of the array (values don't matter), then check whether the number
# of keys of the hash is the same as the number of elements in the array.
# We'll use the hash %_ and the array @_. A hash in scalar context
# gives the number of keys in the hash.
#
# We assume each line of input contains two sets of integers, the
# integers separated by white space, and the sets with semi-colons.
# For each line of input, we print either a 1 or a 0 to the output.
#

while (<>) {
    %_ = map {$_ => $_} @_ = /[-+]?[0-9]+/g; say %_ == @_ ? 1 : 0;
}

__END__
