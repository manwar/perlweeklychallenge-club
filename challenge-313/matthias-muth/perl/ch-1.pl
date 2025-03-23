#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 313 Task 1: Broken Keys
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub broken_keys( $name, $typed ) {
    my $pattern = join "", map "$_+", split "", $name;
    return $typed =~ /^$pattern$/;
}

use Test2::V0 qw( -no_srand );

is broken_keys( "perl", "perrrl" ), T,
    'Example 1: broken_keys( "perl", "perrrl" ) is true';
is broken_keys( "raku", "rrakuuuu" ), T,
    'Example 2: broken_keys( "raku", "rrakuuuu" ) is true';
is broken_keys( "python", "perl" ), F,
    'Example 3: broken_keys( "python", "perl" ) is false';
is broken_keys( "coffeescript", "cofffeescccript" ), T,
    'Example 4: broken_keys( "coffeescript", "cofffeescccript" ) is true';

done_testing;
