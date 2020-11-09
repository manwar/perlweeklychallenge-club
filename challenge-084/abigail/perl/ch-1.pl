#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# You are given an integer $N.
#
# Write a script to reverse the given integer and print the result.
# Print 0 if the result doesn't fit in 32-bit signed integer.
# 
# The number 2,147,483,647 is the maximum positive value for a 32-bit
# signed binary integer in computing.
# 

#
# This is two challenges in one. First, we have to reverse a given
# integer -- which is trivial using Perl's "reverse" buildin.
#
# For the second part, we have to compare it against a given
# maximum value. We *don't* have to write code to handle huge
# numbers -- if the number is too big to handle, Perl will treat
# it as "Inf", which is larger than any regular integers.
#
# There's a tiny thing to consider. 2,147,483,647 is the largest
# positive value which fits in a 32-bit signed integer, but the
# smallest integer which fits is -2,147,483,648 [1]. So, if the input
# is 8463847412, the output should 0, but if the input is -8463847412,
# the output should be -2147483648.
#
# [1] We're assuming 2s-complement integers, which seems to have
#     been the norm for the past 50 years.
#

my $MAX = 2_147_483_647;  # Maximum value which fits in a 32-bit signed integer.
my $MIN = - $MAX - 1;     # Minimum value which fits in a 32-bit signed integer.

while (<>) {
    chomp;
    #
    # Reverse the numeric part; this keeps the sign as is.
    #
    s/[0-9]+/reverse $&/e;

    #
    # Either print 0, or the result.
    #
    say $_ > $MAX || $_ < $MIN ? 0 : $_;
}

__END__
