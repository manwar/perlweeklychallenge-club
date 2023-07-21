#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub shuffle_string_substr($string, @indices) {
    my $r = ' ' x @indices;
    substr $r, $indices[$_], 1, substr $string, $_, 1 for 0 .. $#indices;
    return $r
}

sub shuffle_string_hash($string, @indices) {
    my %rev = reverse %indices[0 .. $#indices];
    join "", map { substr $string, $rev{$_}, 1, substr $string, $_, 1 }
             0 .. $#indices
}

use Test::More tests => 2 * 2;
my %implementation = (substr => *shuffle_string_substr{CODE},
                      hash   => *shuffle_string_hash{CODE});
for my $shuffle_string (keys %implementation) {
    is $implementation{$shuffle_string}
            ->(lacelengh => 3, 2, 0, 5, 4, 8, 6, 7, 1),
        'challenge',
        "Example 1 - $shuffle_string";

    is $implementation{$shuffle_string}->(rulepark => 4, 7, 3, 1, 0, 5, 2, 6),
        'perlraku',
        "Example 2 - $shuffle_string";
}

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    substr => sub { shuffle_string_substr(
        lacelengh => 3, 2, 0, 5, 4, 8, 6, 7, 1) },
    hash  => sub  { shuffle_string_hash(
        lacelengh => 3, 2, 0, 5, 4, 8, 6, 7, 1) },
});

__END__

           Rate   hash substr
hash   153947/s     --   -66%
substr 455856/s   196%     --
