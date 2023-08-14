#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use Algorithm::Permute;

sub cute_list_count {
    my ($n)   = @_;
    my @list  = ( 1 .. $n );
    my $count = 0;

    Algorithm::Permute::permute {
        if ( is_cute(@list) ) {
            $count++;
        }
    }
    @list;

    return $count;
}

sub is_cute {
    my (@list) = @_;
    for my $i ( 0 .. $#list ) {
        return 0 if ( $list[$i] % ( $i + 1 ) != 0 ) && ( ( $i + 1 ) % $list[$i] != 0 );
    }
    return 1;
}

is( cute_list_count(2), 2, 'Example' );

done_testing();
