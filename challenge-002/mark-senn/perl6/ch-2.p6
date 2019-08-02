#
# Retrieved from
#     https://perlweeklychallenge.org/blog/perl-weekly-challenge-002
# on 2019-04-06 at 21:28 -04:
#
#     Challenge #2
#
#     Write a script that can convert integers to and from a base35
#     representation, using the characters 0-9 and A-Y. Dave Jacoby
#     came up with nice description about base35 [1], in case you needed
#     some background.
#     [1] https://gist.github.com/jacoby/764bb4e8a5d3a819b5fbfa497fcb3454
#

# They didn't say how the numbers should be input and output so
# will assume it is ok to have the integer hard-coded in the script.

# Run using Perl 6.
use v6;

my $input  = -37;
my $base35 = $input.base(35);
my $output = $base35.parse-base(35);

print qq:to/END/;
input  was $input
base35 is  $base35
output is  $output
END
