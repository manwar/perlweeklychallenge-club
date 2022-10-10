package main;
use strict;
use warnings;

sub mask_code {
    my @in_list = @_;

    my @out_list;

    for my $item (@in_list) {
        $item
            =~ s/(.*?)[a-z0-9] (.*?)[a-z0-9] (.*?)[a-z0-9] (.*?)[a-z0-9]/$1x$2x$3x$4x/msx;
        push @out_list, $item;
    }

    return \@out_list;
}

use Test::More;

is_deeply(
    mask_code( ( 'ab-cde-123', '123.abc.420', '3abc-0010.xy' ) ),
    [ 'xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy' ]
);

is_deeply( mask_code( ( '1234567.a', 'a-1234-bc', 'a.b.c.d.e.f' ) ),
    [ 'xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f' ] );

done_testing;
1;
