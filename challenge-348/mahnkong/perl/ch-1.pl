use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    return undef if length($str) % 2;
    my $left = substr($str, 0, length($str) / 2);
    my $right = substr($str, length($str) / 2, length($str));

    my $vowels_left = () = $left =~ /[aeiou]/gi;
    my $vowels_right = () = $right =~ /[aeiou]/gi;

    return ($vowels_left > 0 && $vowels_left == $vowels_right ? 1 : 0);

}

is(run("textbook"), 0, "Example 1");
is(run("book"), 1, "Example 2");
is(run("AbCdEfGh"), 1, "Example 3");
is(run("rhythmmyth"), 0, "Example 4");
is(run("UmpireeAudio"), 0, "Example 5");
