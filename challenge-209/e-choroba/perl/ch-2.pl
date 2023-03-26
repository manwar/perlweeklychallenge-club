#! /usr/bin/perl
use warnings;
use strict;

use Test2::V0;

use experimental qw( signatures );

use Graph::Undirected;

sub merge_account(@accounts) {
    my %seen;
    for my $idx (0 .. $#accounts) {
        my $account = $accounts[$idx];
        my ($name, @addresses) = @$account;
        undef $seen{$_}{$name}{$idx} for @addresses;
    }

    my $g = 'Graph::Undirected'->new(unionfind => 1);
    for my $address (keys %seen) {
        for my $name (keys %{ $seen{$address} }) {
            my @indices = keys %{ $seen{$address}{$name} };
            for my $i (0 .. $#indices - 1) {
                for my $j ($i + 1 .. $#indices) {
                    $g->add_edge(@indices[$i, $j]);
                }
            }
        }
    }

    for my $component ($g->connected_components) {
        my $first = shift @$component;
        my %emails;
        @emails{ @{ $accounts[$first] }[1 .. $#{ $accounts[$first] }] } = ();
        for my $next (@$component) {
            @emails{ @{ $accounts[$next] }[1 .. $#{ $accounts[$next] }] } = ();
            undef $accounts[$next];
        }
        $accounts[$first] = [$accounts[$first][0], keys %emails];
    }
    return [grep defined, @accounts]
}

plan 8;
sub verify($got, $expected, $name) {
    is $got, bag {
        for my $account (@$expected) {
            item bag {
                item $_ for @$account;
                end();
            }
        }
        end();
    }, $name;

    is $got, bag {
        item array {
            item $_->[0];
            etc();
        } for @$expected;
        end();
    }, "$name: name goes first";
}

verify(merge_account(['A', 'a1@a.com', 'a2@a.com'],
                     ['B', 'b1@b.com'],
                     ['A', 'a3@a.com', 'a1@a.com']),
       [['A', 'a1@a.com', 'a2@a.com', 'a3@a.com'],
        ['B', 'b1@b.com']],
       'Example 1');

verify(merge_account(['A', 'a1@a.com', 'a2@a.com'],
                     ['B', 'b1@b.com'],
                     ['A', 'a3@a.com'],
                     ['B', 'b2@b.com', 'b1@b.com']),
       [['A', 'a1@a.com', 'a2@a.com'],
        ['A', 'a3@a.com'],
        ['B', 'b1@b.com', 'b2@b.com']],
       'Example 2');

verify(merge_account(['A', 'a1@a.com', 'a2@a.com'],
                     ['A', 'b1@b.com', 'a1@a.com'],
                     ['A', 'a3@a.com', 'b1@b.com']),
       [['A', 'a1@a.com', 'a2@a.com', 'a3@a.com', 'b1@b.com']],
       'Merge 3');

verify(merge_account(['A', 'a1@a.com', 'a2@a.com'],
                     ['A', 'b1@b.com', 'a1@a.com'],
                     ['A', 'a3@a.com', 'b1@b.com'],
                     ['A', 'a3@a.com', 'b2@b.com']),
       [['A', 'a1@a.com', 'a2@a.com', 'a3@a.com', 'b1@b.com', 'b2@b.com']],
       'Merge 4');
