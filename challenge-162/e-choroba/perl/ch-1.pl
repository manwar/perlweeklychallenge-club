#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ sum };

sub isbn_13_check_digit {
    my ($isbn) = @_;
    $isbn =~ s/-//g;
    substr $isbn, -1, 1, "" if 13 == length $isbn;
    my $i = 0;
    return 10 - ((sum(map $_ * (1 + 2 * ($i++ % 2)),
                      split //, $isbn)
                  % 10) || 10);
}

use Test::More tests => 3;

is isbn_13_check_digit('978-0-306-40615-7'), 7, 'Example';

is isbn_13_check_digit('978-0-306-40615'), 7, 'Without the last digit';
is isbn_13_check_digit('978-3-16-148410-0'), 0, 'Another example';
