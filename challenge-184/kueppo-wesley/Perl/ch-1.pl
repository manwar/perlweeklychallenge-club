#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my ( @list, $i ) = qw(ab1234 cd5678 ef1342);
s/^../sprintf "%02d", $i++/e foreach @list;

is_deeply( [ @list ], [ qw(001234 015678 021342) ], "sequenced number?" );

done_testing( 1 );
