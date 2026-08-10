#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub similar_list($list1, $list2, $list3) {
    return unless @$list1 == @$list2;

  ELEMENT:
    for my $i (0 .. $#$list1) {
        next ELEMENT if $list1->[$i] eq $list2->[$i];

        for my $subst (@$list3) {
            next ELEMENT if in($list1->[$i], $subst)
                         && in($list2->[$i], $subst);
        }
        return
    }
    return 1
}

sub in($e, $l) { grep $_ eq $e, @$l }


use Test2::V0;
plan(5 + 2);
use if ($] >= 5.036), builtin => qw( true false );
use if ($] <  5.036), constant => {true => 1, false => 0};


is similar_list(['great', 'acting'],
                ['fine', 'drama'],
                [['great', 'fine'], ['acting', 'drama']]),
    bool(true),
    'Example 1';


is similar_list(['apple', 'pie'],
                ['banana', 'pie'],
                [['apple', 'peach'], ['peach', 'banana']]),
    bool(false),
    'Example 2';


is similar_list(['perl4', 'python'],
                ['raku', 'python'],
                [['perl4', 'perl5', 'raku']]),
    bool(true),
    'Example 3';


is similar_list(['enjoy', 'challenge'],
                ['love', 'weekly', 'challenge'],
                [['enjoy', 'love']]),
    bool(false),
    'Example 4';


is similar_list(['fast', 'car'],
                ['quick', 'vehicle'],
                [['quick', 'fast'], ['vehicle', 'car']]),
    bool(true),
    'Example 5';

is similar_list(['fast', 'car'],
                ['quick', 'vehicle'],
                [['car', 'vehicle'], ['quick', 'fast']]),
    bool(true),
    'Map in different directions';

is similar_list(['a', 'b'],
                ['c', 'd'],
                [['b', 'a', 'd'], ['a', 'b', 'c']]),
    bool(true),
    'Repetitions';
