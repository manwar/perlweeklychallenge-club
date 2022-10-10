#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use JSON;
my $json = JSON->new;

my @lists = (
    [ 'ab-cde-123', '123.abc.420', '3abc-0010.xy' ],
    [ '1234567.a',  'a-1234-bc',   'a.b.c.d.e.f' ]
);

for my $list (@lists) {
    my @masked = mask_list( $list->@* );
    my $list_s = $json->encode($list);
    my $masked = $json->encode( \@masked );
    say <<"END";
        Input:  ($list_s)
        Output: ($masked)
END
}

sub mask_list (@list) {
    return map { mask_element($_) } @list;
}

sub mask_element ( $e, $m = 'x', $n = 4 ) {
    my $c = 0;
    for my $i ( 0 .. length $e ) {
        if ( substr( $e, $i, 1 ) =~ /[a-z0-9]/ ) {
            substr( $e, $i, 1 ) = $m;
            $c++;
            last if $c >= $n;
        }
    }
    return $e;
}
