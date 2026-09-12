#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';
use List::Util qw(first);

# Task 2: FNR Character
# Find the first non-repeating character dynamically at each step.
# Output '#' if no non-repeating character exists at that point.

sub get_fnr ($input) {
    return '' if !defined $input || length($input) == 0;

    my %fnr_count;
    my @fnr_queue;
    my $result = '';

    for my $char ( split //, $input ) {
        $fnr_count{$char}++;

        if ( $fnr_count{$char} == 1 ) {
            push @fnr_queue, $char;
        }
        else {
            my $pos;
            for my $i ( 0 .. $#fnr_queue ) {
                if ( $fnr_queue[$i] eq $char ) {
                    $pos = $i;
                    last;
                }
            }
            splice @fnr_queue, $pos, 1 if defined $pos;
        }

        $result .= @fnr_queue ? $fnr_queue[-1] : '#';
    }

    return $result;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( get_fnr('ababc'),  'abb#c',  'Example 1' );
    is( get_fnr('xyzzyx'), 'xyzyx#', 'Example 2' );

    is( get_fnr(''),       '',       'Empty string' );
    is( get_fnr('a'),      'a',      'Single char' );
    is( get_fnr('aa'),     'a#',     'Two same chars' );

    done_testing();
}
else {
    say get_fnr( $ARGV[0] );
}
