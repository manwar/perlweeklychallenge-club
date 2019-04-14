# Perl Weekly Challenge - 003
# Challenge #1
#
# See
#     http://bit.ly/pwc-003
# for more information.

# Run using Perl 6.
use v6;

my @prime = (2, 3, 5);
my @product = @prime <<*>> @prime;
@product.join("\n").say;
