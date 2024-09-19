#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 287 Task 1: Strong Password
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( sum min );

our $verbose = 0;
sub vsay( @args ) { say @args if $verbose }

use constant MIN_PASSWORD_LENGTH => 6;

sub strong_password( $str ) {
    vsay "strong_password( $str )";

    # Make pattern matches easier to write.
    $_ = $str;

    my ( $cost, $available_inserted, $available_replaced ) = ( 0, 0, 0 );

    # 1: Do *inserts* for bringing the password up to length.
    vsay "  password length: ", length();
    if ( length() < MIN_PASSWORD_LENGTH ) {
        $available_inserted = MIN_PASSWORD_LENGTH - length();
        $cost += $available_inserted;
        vsay "  insert $available_inserted for password length";
        vsay "  cost is at $cost";
    }

    # 2: Use the inserted characters to add missing categories
    #    (*no additional cost!*),
    my $n_missing_categories = sum( ! /\d/, ! /[a-z]/, ! /[A-Z]/ );
    vsay "  $n_missing_categories missing categories";
    if ( $n_missing_categories && $available_inserted ) {
        my $n_to_use = min( $n_missing_categories, $available_inserted );
        $n_missing_categories -= $n_to_use;
        vsay "    used $n_to_use inserts for missing categories";
    }

    # 3: If there still are categories missing,
    #    we *replace* existing characters.
    if ( $n_missing_categories ) {
        $available_replaced = $n_missing_categories;
        $cost += $available_replaced;
        vsay "  replace $available_replaced for categories";
        vsay "  cost is at $cost";
    }

    # 4: Deal with long repeating sequences (3 or more same characters).
    while ( /(.)\1\1\1*/g ) {
        my $sequence_length = length( $& );
        vsay "  sequence '$&', length $sequence_length";
        while ( $sequence_length > 2 && $available_replaced ) {
            vsay "  use replace in sequence";
            $sequence_length -= 3;
            --$available_replaced;
        }
        while ( $sequence_length > 2 && $available_inserted ) {
            vsay "  use insert in sequence";
            $sequence_length -= 2;
            --$available_inserted;
        }
        while ( $sequence_length > 2 ) {
            vsay "  replace in sequence";
            vsay "  cost is at $cost";
            $sequence_length -= 3;
            ++$cost;
        }
    }
    return $cost;
}

use Test2::V0 qw( -no_srand );
is strong_password( "a" ), 5,
    'Example 1: strong_password( "a" ) == 5';
is strong_password( "aB2" ), 3,
    'Example 2: strong_password( "aB2" ) == 3';
is strong_password( "PaaSW0rd" ), 0,
    'Example 3: strong_password( "PaaSW0rd" ) == 0';
is strong_password( "Paaasw0rd" ), 1,
    'Example 4: strong_password( "Paaasw0rd" ) == 1';
is strong_password( "aaaaa" ), 2,
    'Example 5: strong_password( "aaaaa" ) == 2 (like "aa1aaB")';

is strong_password( "" ), 6,
    'Extra 1: strong_password( "" ) == 6 (like "1aBcde")';

is strong_password( "abcABC" ), 1,
    'Extra 2: strong_password( "abcABC" ) == 1 (like "a1cABC")';
is strong_password( "abcdef" ), 2,
    'Extra 3: strong_password( "abcdef" ) == 2 (like "a1Adef")';

is strong_password( "aaa1B" ), 1,
    'Extra 4: strong_password( "aaa1B" ) == 1 (like "aab1B")';
is strong_password( "aaaa1B" ), 1,
    'Extra 5: strong_password( "aaaa1B" ) == 1 (like "aaba1B")';
is strong_password( "aaaaa1B" ), 1,
    'Extra 6: strong_password( "aaaaa1B" ) == 1 (like "aabaa1B")';
is strong_password( "aaaaaa1B" ), 2,
    'Extra 7: strong_password( "aaaaaa1B" ) == 2 (like "aabaab1B")';
is strong_password( "aaaaaaa1B" ), 2,
    'Extra 8: strong_password( "aaaaaaa1B" ) == 2 (like "aabaaba1B")';
is strong_password( "aaaaaaaa1B" ), 2,
    'Extra 9: strong_password( "aaaaaaaa1B" ) == 2 (like "aabaabaa1B")';
is strong_password( "aaaaaaaaaaaa1B" ), 4,
    'Extra 10: strong_password( "aaaaaaaaaaaa1B" ) == 4 (like "aabaabaabaab1B")';

is strong_password( "aaaBc" ), 1,
    'Extra 11: strong_password( "aaaBc" ) == 1 (like "aa1aBc")';
is strong_password( "aaaabC" ), 1,
    'Extra 12: strong_password( "aaaabC" ) == 1 (like "aa1aabC")';

is strong_password( "aaaacccc" ), 2,
    'Extra 13: strong_password( "aaaacccc" ) == 2 (like "aa1accBc")';
is strong_password( "aaaaaabbbbbb" ), 4,
    'Extra 14: strong_password( "aaaaaabbbbbb" ) == 4 (like "aa1aaXbbYbbY")';
is strong_password( "aaacc" ), 2,
    'Extra 15: strong_password( "aaacc" ) == 2 (like "aa1ccX")';

done_testing;
