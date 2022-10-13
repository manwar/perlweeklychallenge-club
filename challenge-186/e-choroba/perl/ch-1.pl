#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use List::MoreUtils qw{ zip };

sub zip_list (@list){
    die 'Not the same length!' if @list % 2;
    my @list1 = splice @list, 0, @list / 2;
    return zip(@list1, @list)
}

use Test2::V0;
plan 5;
my @a = qw( 1 2 3 );
my @b = qw( a b c );

is [zip_list(@a, @b)], [qw[ 1 a 2 b 3 c ]], 'Exapmle 1';
is [zip_list(@b, @a)], [qw[ a 1 b 2 c 3 ]], 'Example 2';

my @c = qw( 1 2 3 4 5 6 );
my @d = qw( a b c d e f );
is [zip_list(@c, @d)], [qw[ 1 a 2 b 3 c 4 d 5 e 6 f ]], 'Length 6';

my @e = qw( 1 2 3 4 );
my @f = qw( a b c d );
is [zip_list(@e, @f)], [qw[ 1 a 2 b 3 c 4 d ]], 'Length 4';

my @g = qw( 1 2 3 );
my @h = qw( a b );
my $e = dies { zip_list(@g, @h) };
like $e, qr/Not the same length/;
