#!/usr/bin/env perl
#
# ch-1.pl - ISBN 13 Check
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use Carp qw< croak carp >;
use List::Util qw< sum pairs pairmap >;

use Test::More;
use Test::Exception;

ok  valid_isbn13('978-0-306-40615-7');
ok  valid_isbn13('978-1-56619-909-4');
ok !valid_isbn13('123-4-56789-012-3');
dies_ok { valid_isbn13('invalid isbn') }       'Not an ISBN at all';
dies_ok { valid_isbn13('978-0-306-40615') }    'Too short';
dies_ok { valid_isbn13('978-0-306-40615-71') } 'Too long';
dies_ok { valid_isbn13('978-0-306-4B615-7') }  'Non-digit';

done_testing;

# We use a relaxed interpretation of an ISBN 13 here, because the parts are
# not fixed lengths, so as long as we have 13 digits, we don't care where (or
# if) the dashes are placed.
sub valid_isbn13 {
    local $_ = shift;
    croak "Invalid ISBN" unless /^[0-9-]+$/;
    my @digits = grep { /\d/ } split //;
    croak "Only 13 digit ISBNs are supported" if @digits != 13;
    my $check = pop @digits;

    # Sum of every odd number plus 3 x every even number
    10 - (sum pairmap { $a + 3*$b } @digits) % 10 == $check;
}
