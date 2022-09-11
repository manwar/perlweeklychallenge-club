#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

sub find_hotter_days {
    my ( %temp, @result );

    while ( my $date_temp = <DATA> ) {
        my ( $date, $temp ) = split /, /, $date_temp;
        $temp{$date} = $temp;
    }

    foreach my $key ( keys %temp ) {
        my $prev = $key =~ s/-//gr;

        $prev--;
        $prev =~ s/^(.{4})(.{2})(.{2})$/$1-$2-$3/;

        push @result, $key if exists $temp{$prev} and $temp{$prev} < $temp{$key};
    }

    return sort @result;
}

is_deeply(
    [ find_hotter_days() ],
    [
        sort qw(
            2022-08-02
            2022-08-05
            2022-08-06
            2022-08-08
            2022-08-10
        )
    ],
    "Did you find hotter days?"
);

done_testing( 1 );

__DATA__
2022-08-01, 20
2022-08-09, 10
2022-08-03, 19
2022-08-06, 24
2022-08-05, 22
2022-08-10, 28
2022-08-07, 20
2022-08-04, 18
2022-08-08, 21
2022-08-02, 25
