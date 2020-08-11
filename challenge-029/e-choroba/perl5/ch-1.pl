#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub expand {
    my ($string) = @_;
    grep length, glob $string =~ s/(\s)/\\$1/gr
}

use Test::More tests => 5;
use Test::Deep;

cmp_deeply [expand('Perl {Daily,Weekly,Monthly,Yearly} Challenge')],
    bag('Perl Daily Challenge',
        'Perl Weekly Challenge',
        'Perl Monthly Challenge',
        'Perl Yearly Challenge'),
    'Original example';

cmp_deeply [expand('{a,,}')],
    bag(qw( a )),
    'Empty results excluded';

cmp_deeply [expand('a{b,c}{d,e}f{g,h,i}')],
    bag('abdfg', 'abdfh', 'abdfi',
        'abefg', 'abefh', 'abefi',
        'acdfg', 'acdfh', 'acdfi',
        'acefg', 'acefh', 'acefi'),
    'Multiple brackets';

cmp_deeply [expand('{{a,b}c,d}e')],
    bag(qw( ace bce de )),
    'Nested brackets';

cmp_deeply [expand('{{a,b}c,d}{g,}')],
    bag(qw( acg ac bcg bc dg d )),
    'Everything combined';

