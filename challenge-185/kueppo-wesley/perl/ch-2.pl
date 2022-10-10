#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

sub mask_first_four {
    my $x;
    my $lists = [ [ 'ab-cde-123', '123.abc.420', '3abc-0010.xy' ], [ '1234567.a', 'a-1234-bc', 'a.b.c.d.e.f' ], ];

    map {
        map { s{ ^( (?: (?<a> [^a-z0-9]* ) [a-z0-9] (?&a) ){4} ) } { $1 =~ s{ [a-z0-9] }{x}gxr }xe }
            @$_
    } @$lists;

    return $lists;
}

# Testing
my $expected = [ [ 'xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy' ], [ 'xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f' ] ];

is_deeply( mask_first_four, $expected, 'Did you mask correctly?' );

done_testing( 1 );
