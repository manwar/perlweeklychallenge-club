#!/usr/bin/env raku

use Test;

my @examples = (
    {
        in  => "",
        out => ""
    },
    {
        in  => "reverse the given string",
        out => "gnirts nevig eht esrever"
    },
    {
        in  => "Perl is Awesome",
        out => "emosewA si lreP"
    },
    {
        in  => "v1.0.0-Beta!",
        out => "!ateB-0.0.1v"
    },
    {
        in  => "racecar",
        out => "racecar"
    },
);

is reverse_string($_<in>), $_<out> for @examples;

done-testing;

sub reverse_string(Str $str) {
    my @chars = $str.comb;
    my $_str  = '';

    loop (my $i = @chars.elems - 1; $i >= 0; $i--) {
        $_str ~= @chars[$i];
    }

    return $_str;
}
