#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

{
    if ( $ENV{TESTING} ) {
        test_count_subsequences();
    }
    else {
        my ( $S, $T ) = @ARGV;
        die "usage: $0 STRING STRING\n" unless @ARGV == 2;

        say count_subsequences( $S, $T );
    }
}

sub test_count_subsequences() {

    my @test_cases = ( [ "littleit", "lit", 5 ], [ "london", "lon", 3 ], );

    require Test::More;
    Test::More->import( tests => scalar @test_cases );

    for my $test (@test_cases) {
        my ( $string, $target, $count ) = @{$test};
        ok(
            count_subsequences( $string, $target ) == $count,
            "$string contains $count subsequences matching $target"
        );
    }
}
use List::Util qw(first);

sub count_subsequences ( $string, $target, $string_position = 0,
    $target_position = 0 )
{
    return 0 if ( $string_position >= length($string) );

    my $count = count_subsequences( $string, $target, $string_position + 1,
        $target_position );

    my $string_char = substr( $string, $string_position, 1 );
    my $target_char = substr( $target, $target_position, 1 );
    if ( $string_char eq $target_char ) {
        if ( $target_position == length($target) - 1 ) {
            $count += 1;
        }
        else {
            $count += count_subsequences(
                $string, $target,
                $string_position + 1,
                $target_position + 1
            );
        }
    }

    return $count;
}

