#!/usr/bin/env raku

use Test;

my @examples = (
    { in => ["ab","bc","cd","zy"],         out => "zy"   },
    { in => ["cba","fed","azy"],           out => "azy"  },
    { in => ["pop","ada","beb","cfc"],     out => "pop"  },
    { in => ["aaaa","zzzz","mmmm","aaba"], out => "aaba" },
    { in => ["aceg","bdfh","cegi","azbz"], out => "azbz" },
);

is-deeply odd-one-out(|$_<in>), $_<out> for @examples;

done-testing;

sub odd-one-out(*@words) {
    my @diff_keys = @words.map: {
        my @c = .split('', :skip-empty).map(*.ord);
        join ',', (0 .. @c.end - 1).map({ @c[$_ + 1] - @c[$_] });
    };

    my %count;
    %count{$_}++ for @diff_keys;

    my ($unique_key) = %count.keys.grep({ %count{$_} == 1 });
    my ($idx)        = (0 .. @words.end).grep({ @diff_keys[$_] eq $unique_key });

    return @words[$idx];
}
