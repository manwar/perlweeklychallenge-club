#!/usr/bin/env perl
use strict;
use warnings;
use experimental 'regex_sets';

# You are given a list of codes in many random format.

# Write a script to mask first four characters (a-z,0-9) and keep the rest as it is.

# Example 1
# Input: @list = ()
# Output: ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy')
# Example 2
# Input: @list = ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f')
# Output: ('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f')

# breaks if the string has an x in the first four
sub mask_first_four {
    my $code = shift;

    $code =~ s/(?[ [:alnum:] - [x] ])/x/ for 1 .. 4;
    return $code;
}

sub mask_all {
    my @codes = @_;

    return map mask_first_four($_), @codes;
}

use Test::More;

is_deeply [ mask_all('ab-cde-123', '123.abc.420', '3abc-0010.xy') ],
     [ 'xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy' ],
     'example 1';

is_deeply [ mask_all('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f') ],
     [ 'xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f' ],
     'example 2';

done_testing;