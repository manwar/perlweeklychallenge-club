#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my ( @macs, @result ) = qw(1ac2.34f0.b1c2 abc1.20f1.345a);

push @result, tr/.//dr =~ s/(..)(?!$)/$1:/gr foreach @macs;

is_deeply( [ @result ], [ qw(1a:c2:34:f0:b1:c2 ab:c1:20:f1:34:5a) ], "Properly converted mac addresses" );

done_testing( 1 );
