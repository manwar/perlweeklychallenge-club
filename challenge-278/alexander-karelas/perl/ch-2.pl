#!/usr/bin/env perl

use v5.40;

use Test::More;

sub do_it ($str, $char) {
    my ($substr1, $substr2) = $str =~ /^(.*?\Q$char\E)?(.*)\z/;
    $substr1 //= '';
    $substr1 = join '', sort(split //, $substr1);
    return "$substr1$substr2";
}

is do_it('challenge', 'e'), 'acehllnge', 'Example 1';
is do_it('programming', 'a'), 'agoprrmming', 'Example 2';
is do_it('champion', 'b'), 'champion', 'Example 3';

done_testing();