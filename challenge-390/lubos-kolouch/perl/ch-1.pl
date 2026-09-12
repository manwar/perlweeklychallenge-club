#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 1: Decode String
# The encoding rule is: K[encoded_string], where the encoded_string inside
# the square brackets is repeated exactly K > 0 times.

sub decode_string ($str) {
    my @count_stack;
    my @str_stack;
    my $curr_str = '';
    my $curr_num = 0;

    for my $char ( split //, $str ) {
        if ( $char =~ /\d/ ) {
            $curr_num = $curr_num * 10 + $char;
        }
        elsif ( $char eq '[' ) {
            push @count_stack, $curr_num;
            push @str_stack,   $curr_str;
            $curr_num = 0;
            $curr_str = '';
        }
        elsif ( $char eq ']' ) {
            my $count    = pop @count_stack;
            my $prev_str = pop @str_stack;
            $curr_str = $prev_str . ( $curr_str x $count );
        }
        else {
            $curr_str .= $char;
        }
    }

    return $curr_str;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( decode_string("2[3[a]]"),       "aaaaaa",     "Example 1" );
    is( decode_string("10[a]"),         "aaaaaaaaaa", "Example 2" );
    is( decode_string("a2[b]c3[d]e"),   "abbcddde",   "Example 3" );
    is( decode_string("2[a2[b]c]"),     "abbcabbc",   "Example 4" );
    is( decode_string("1[a]2[b3[c]]"), "abcccbccc",  "Example 5" );

    done_testing();
}
else {
    say decode_string( $ARGV[0] );
}
