#!/usr/bin/perl
use warnings;
use strict;

sub shortest_unique_prefixes {
    my @words = @_;
    my (%prefixes, %used);
    for my $word (@words) {
        my $i = 1;
        while ($i <= length $word) {
            my $prefix = substr $word, 0, $i++;
            if (exists $prefixes{$prefix}) {
                undef $used{$prefix};
                my $old = $prefixes{$prefix};
                $prefixes{ substr $old, 0, $i } = delete $prefixes{$prefix};
                die "Duplicate prefix: $prefix ($old:$word)"
                    if $i > length $word || $i > length $old;

            } elsif (! exists $used{$prefix}) {
                $prefixes{$prefix} = $word;
                last
            }
        }
    }
    my %to_prefixes = reverse %prefixes;
    return [@to_prefixes{@words}]
}

use Test::More tests => 4;
use Test::Exception;

is_deeply
    shortest_unique_prefixes(qw( alphabet book carpet cadmium cadeau alpine )),
    [qw[ alph b car cadm cade alpi ]],
    'sample input';

throws_ok {
    shortest_unique_prefixes(qw( perl perl ))
} qr/Duplicate prefix: perl /, 'detect duplicate';

throws_ok {
    shortest_unique_prefixes(qw( A AA AAA ))
} qr/Duplicate prefix: A /, 'common prefix asc';

throws_ok {
    shortest_unique_prefixes(qw( BBB BB B ))
} qr/Duplicate prefix: B+ /, 'common prefix desc';
