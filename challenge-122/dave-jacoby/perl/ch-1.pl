#!/usr/bin/env perl

use feature qw{say state signatures};
use strict;
use warnings;
use utf8;
no warnings qw{ experimental };

use Carp;
use Getopt::Long;
use List::Util qw{sum0};

my ( $start, $end, $leap ) = ( 1, 2, 1 );
GetOptions(
    'start=i' => \$start,
    'end=i'   => \$end,
    'leap=i'  => \$leap,
);
croak 'Bad input' if $start >= $end || $start < 1 || $leap < 1;

my $streamer = factory( $start, $end, $leap );
my $z        = 0;
while ( $z = $streamer->() ) {
    last unless defined $z;
    stream_avg($z);
}

sub stream_avg ($n) {
    state $arr = [];
    push $arr->@*, $n;
    my $cnt = scalar $arr->@*;
    if ( $cnt == 1 ) {
        say qq{Average of first number is $n};
    }
    else {
        my $sum = sum0 $arr->@*;
        my $str = join '+', $arr->@*;
        my $avg = ($sum) / $cnt;
        say qq{Average of first $cnt numbers ($str)/$cnt = $avg};
    }
}

sub factory ( $start, $end, $input ) {
    say <<"END";
    START   $start
    END     $end
    LEAP    $leap
END
    return sub {
        state $c = $start;
        my $d = $c;
        $c += $leap;
        return undef if $d > $end;
        return $d;
    }
}
