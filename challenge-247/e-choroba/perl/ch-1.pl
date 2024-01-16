#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ max shuffle };

sub secret_santa(@names) {
    return {} unless @names;

    my %family;
    undef $family{ family($_) }{$_} for @names;

    my %size;
    undef $size{ scalar keys %{ $family{$_} } }{$_} for keys %family;

    my @n1 = map keys %{ $family{$_} },
             map keys %{ $size{$_} },
             sort { $a <=> $b }
             keys %size;
    my @n2 = (@n1[$#n1 / 2 + 1 .. $#n1], @n1[0 .. $#n1 / 2]);
    my %pair;
    @pair{@n1} = @n2;
    return \%pair
}

sub family($name) {
    ( $name =~ /(\w+)$/ )[0]
}

use Test2::V0 -srand => srand;
use experimental qw( signatures );

sub is_correct($names, $label) {
    subtest $label => sub {
        my $pair = secret_santa(@$names);

        is [keys %$pair], bag { item $_ for @$names; end }, "keys";
        is [values %$pair], bag { item $_ for @$names; end }, "values";
        is 0, grep($pair->{$_} eq $_, keys %$pair), "no self";

        my %family;
        ++$family{ family($_) } for @$names;
        my $same_family = 0;
        $family{$_} > @$names / 2
            and $same_family += 2 * $family{$_} - @$names
            for keys %family;

        is grep(family($_) eq family($pair->{$_}), keys %$pair), $same_family,
            "same family $same_family";
    };
}

is_correct(['Mr. Wall',
            'Mrs. Wall',
            'Mr. Anwar',
            'Mrs. Anwar',
            'Mr. Conway',
            'Mr. Cross'],
           'Example 1',),

is_correct(['Mr. Wall', 'Mrs. Wall', 'Mr. Anwar'], 'Example 2');

for (1 .. 10) {
    my @families = map "F$_", ('a' .. 'z')[0 .. 1 + rand 8];
    my @names = map {
        my $f = $_; map "$_ $f", ('Aa' .. 'Zz')[0 .. 1 + rand 6]
    } @families;
    is_correct([@names], "random $_");
}

done_testing();
