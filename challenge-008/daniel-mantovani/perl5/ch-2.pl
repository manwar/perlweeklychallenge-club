
use strict;
use warnings;
use v5.10;
use utf8;
use open qw(:std :utf8);

# Write a function, ‘center’, whose argument is a list of strings, which will be lines of text. The function
# should insert spaces at the beginning of the lines of text so that if they were printed, the text would be
# centered, and return the modified lines.

# For example,

# center("This", "is", "a test of the", "center function");
# should return the list:

# "     This", "      is", " a test of the", "center function"
# because if these lines were printed, they would look like:

#        This
#         is
#    a test of the
#   center function

sub center {
    my @list = @_;

    # size of bigger line (in chars, not in bytes):
    my $sz;

    # iterate over the list replacing chars in the list, and actualize max chars
    for my $i ( 0 .. $#list ) {

        # get rid of undefined lines
        $list[$i] //= '';

        # now actualize max size
        $sz = !defined $sz || length $list[$i] > $sz ? length $list[$i] : $sz;
    }

    # nothing to do if $sz was not defined
    return @list unless defined $sz;

    # pad spaces in front in each line, to center the text

    return map { ' ' x int( ( $sz - length ) / 2 ) . $_ } @list;
}
my @list = <>;
chomp @list;
say for center @list;

#
# you can test the example case with the following command executed in the script directory:
# $> echo -e "This\nis\na test of the\ncenter function"|perl ch-2.pl
#
