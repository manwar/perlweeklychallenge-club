#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;
use List::Util qw/all zip/;

sub brokenKeys {
    my ($name, $typed) = @_;
    my $name_cc = characterCounts($name);
    my $typed_cc = characterCounts($typed);

    if (scalar @$name_cc != scalar @$typed_cc){
        return 0;
    }
    return all { $_->[0][0] eq $_->[1][0] && $_->[0][1] <= $_->[1][1] }
                zip $name_cc, $typed_cc;
}

sub characterCounts {
    my $string = shift;
    my @groups;
    my $current = [];

    for my $c (split //, $string){
        if( @$current && $current->[-1] ne $c ){
            push @groups, [$current->[0], scalar @$current];
            $current = [];
        }
        push @$current, $c;
    }
    if ( @$current ) {
        push @groups, [$current->[0], scalar @$current];
    }
    return \@groups;
}

ok(brokenKeys("perl", "perrrl"), "Example 1");
ok(brokenKeys("raku", "rrakuuuu"), "Example 2");
ok(!brokenKeys("python", "perl"), "Example 3");
ok(brokenKeys("coffeescript", "cofffeescccript"), "Example 4");
ok(brokenKeys("", ""), "Example 5");
ok(!brokenKeys("haskell", ""), "Example 6");

done_testing();
