#!/usr/bin/env perl

use v5.38;
use Test::More;

my $examples = {
    1 => { str => 'abbaca',   exp => 'ca' },
    2 => { str => 'azxxzy',   exp => 'ay' },
    3 => { str => 'aaaaaaaa', exp => ''   },
    4 => { str => 'aabccba',  exp => 'a'  },
    5 => { str => 'abcddcba', exp => ''   },
};

foreach my $id (keys %$examples) {
    is(remove_duplicates($examples->{$id}->{str}), $examples->{$id}->{exp})
}

done_testing;

sub remove_duplicates($str) {
    return $str if length($str) < 2;

    for (my $i = 0; $i < length($str) - 1; $i++) {
        if (substr($str, $i, 1) eq substr($str, $i + 1, 1)) {
            my $new_str = substr($str, 0, $i) . substr($str, $i + 2);
            return remove_duplicates($new_str);
        }
    }

    return $str;
}
