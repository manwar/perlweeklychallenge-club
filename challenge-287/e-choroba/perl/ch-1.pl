#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ first };

# We can ignore deletion. We can always replace a character with a character
# of the same class different to the previous and following one instead.
sub strong_password($str) {
    my %agenda = ($str => 0);

    while (1) {
        my %next;
        for my $s (keys %agenda) {

            if (6 > length $s) {
                for my $char (qw( a A 0 )) {
                    $next{ $s . (($char eq substr $str, -1)
                                 ? chr(1 + ord $char)
                                 : $char)
                    } = 1 + $agenda{$s};
                }
            } elsif ($s !~ /[[:lower:]]/
                     || $s !~ /[[:upper:]]/
                     || $s !~ /[0-9]/
                     || $s =~ /(.)\1\1/
            ) {
                for my $l (0 .. length($s) - 1) {

                    my $this      = substr $s, $l, 1;
                    my $previous  = $l > 0 ? substr $s, $l - 1, 1 : 'a';
                    my $following = $l == length($s) - 1
                                    ? 'a'
                                    : substr $s, $l + 1, 1;

                    # Try replacing every character with a lower-cased char,
                    # upper-cased char, and a digit different to the char
                    # itself, the preceding character, and the following
                    # character.
                    $next{ substr($s, 0, $l) . $_ . substr($s, $l + 1) }
                        = 1 + $agenda{$s}
                            for grep defined,
                                map {
                                    first { /[^$this$previous$following]/ }
                                    @$_
                                }
                                [qw[ 0 1 2 ]], [qw[ a b c ]], [qw[ A B C ]];
                }
            } else {
                return $agenda{$s}
            }
        }
        %agenda = %next;
    }
}

use Test::More tests => 5 + 3;

is strong_password('a'), 5, 'Example 1';
is strong_password('aB2'), 3, 'Example 2';
is strong_password('PaaSW0rd'), 0, 'Example 3';
is strong_password('Paaasw0rd'), 1, 'Example 4';
is strong_password('aaaaa'), 2, 'Example 5';

is strong_password('aaaZZZ999'), 3, 'Repeated triplets';
is strong_password('0Zaaab'), 1, 'Creating a triple';
is strong_password('000aaa000'), 3, 'Combined actions';
