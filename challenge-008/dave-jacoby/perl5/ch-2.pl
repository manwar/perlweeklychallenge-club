#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

use List::Util qw{max};

my @list_of_strings = (
"Write a function, 'center', whose argument is a list of strings, which will be",
"lines of text. The function should insert spaces at the beginning of the lines of",
"text so that if they were printed, the text would be centered, and return the",
    "modified lines.",""
);

my @centered_list = center(@list_of_strings);
say join "\n", @list_of_strings;
say join "\n", @centered_list;

# First, we need to know the center point, which relies on us knowing
# the longest line. List::Util is in Core, so you have it, but we could
# just have done ($max) = sort { $b <=> $a } map { length $_ } instead.

# So, knowing the max length in the list of strings, we use it
# to find the difference. We then divide by 2, so we're not just
# right-aligning the text.

# the x operator takes the string on the right of it and copies it
# as many times as the number / equation on the left tells it to.
# We concate that to the front of the string, and voila! Centered!

sub center ( @input ) {
    my $max = max map { length $_ } @input;
    return map { ( ' ' x ( ( $max - length $_ ) / 2 ) ) . $_ } @input;
}
__DATA__
Write a function, 'center', whose argument is a list of strings, which will be
lines of text. The function should insert spaces at the beginning of the lines of
text so that if they were printed, the text would be centered, and return the
modified lines.
