#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 347 Task 1: Format Date
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );
use feature 'try';

use Time::Piece;

sub format_date_q_a_d( $str ) {
    $str =~ s/st|nd|rd|th//;
    my $t = Time::Piece->strptime( $str, "%d %b %Y" );
    return $t->strftime( "%Y-%m-%d" );
}

sub format_date_strict( $str ) {
    $str =~ s/ (?<=1)st | (?<=2)nd | (?<=3)rd | (?<=\d)th //x;
    my $t = do {
        try { Time::Piece->strptime( $str, "%d %b %Y" ) }
        catch( $e ) { undef }
    };
    return
        $t && ( 1900 <= $t->year <= 2100 )
            && $t->strftime( "%d %b %Y" ) eq $str =~ s/^\d\s/0$&/r
        ? $t->strftime( "%Y-%m-%d" )
        : "<invalid date>";
}

sub format_date_own( $str ) {
    my @month_names = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
    my %months = map { ( $month_names[$_] => $_ + 1 ) } keys @month_names;
    my @days_per_month = qw( 0 31 29 31 30 31 30 31 31 30 31 30 31 );

    $str =~ s/ (?<=1)st | (?<=2)nd | (?<=3)rd | (?<=\d)th //x;
    my ( $day, $month_name, $year ) = $str =~ /^(\d{1,2}) (...) (\d{4})$/;
    my $month = $month_name && $months{$month_name};
    return
        $year && ( 1900 <= $year <= 2100 )
            && $month && $day <= $days_per_month[$month]
            && ( $month != 2 || $day != 29
                || ( $year % 4 == 0 && $year % 100 != 0 || $year % 1000 == 0 ) )
        ? sprintf( "%d-%02d-%02d", $year, $month, $day )
        : "<invalid date>";
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ 'Example 1', '1st Jan 2025', '2025-01-01' ],
    [ 'Example 2', '22nd Feb 2025', '2025-02-22' ],
    [ 'Example 3', '15th Apr 2025', '2025-04-15' ],
    [ 'Example 4', '23rd Oct 2025', '2025-10-23' ],
    [ 'Example 5', '31st Dec 2025', '2025-12-31' ],
    [ 'Strict Test 1 (boundaries)', '1st Jan 1900', '1900-01-01' ],
    [ 'Strict Test 2 (boundaries)', '31st Dec 2100', '2100-12-31' ],
    [ 'Strict test 3 (out of range)', '31st Dec 1899', '<invalid date>' ],
    [ 'Strict test 4 (out of range)', '1st Jan 2101', '<invalid date>' ],
    [ 'Strict test 5 (leap day)', '29th Feb 2000', '2000-02-29' ],
    [ 'Strict test 6 (leap day)', '29th Feb 2004', '2004-02-29' ],
    [ 'Strict test 7 (non-existing leap day)', '29th Feb 1900', '<invalid date>' ],
    [ 'Strict test 8 (non-existing leap day)', '29th Feb 2001', '<invalid date>' ],
    [ 'Strict test 9 (non-existing leap day)', '29th Feb 2100', '<invalid date>' ],
    [ 'Strict test 10 (empty string)', '', '<invalid date>' ],
    [ 'Strict test 11 (random non-date string', 'xxx', '<invalid date>' ],
    [ 'Strict test 12 (invalid suffix)', '5st Dec 2025', '<invalid date>' ],
    [ 'Strict test 13 (invalid lower case)', '1st jan 1970', '<invalid date>' ],
    [ 'Strict test 14 (non-existing)', '35th Dec 2025', '<invalid date>' ],
    [ 'Strict test 15 (non-existing)', '29th Feb 1900', '<invalid date>' ],
    [ 'Strict test 16 (non-existing)', '29th Feb 2001', '<invalid date>' ],
    [ 'Strict test 17 (non-existing)', '29th Feb 2100', '<invalid date>' ],
);

# Check quick and dirty version.
my @implementations = (
    [ \&format_date_q_a_d,  "the strptime quick-and-dirty solution", qr/strict/i ],
    [ \&format_date_strict, "the strptime strict solution" ],
    [ \&format_date_own,    "the own solution" ],
);

for ( @implementations ) {
    my ( $sub, $description, $skip ) = $_->@*;
    note "Testing $description";
    for ( @tests ) {
        my ( $test, $str, $expected ) = $_->@*;
        my $todo =
            $skip
            && $test =~ $skip
            && todo "strict checks";
        try {
            is $sub->( $str ), $expected,
                "$test: '$str' => '$expected'";
        }
        catch( $e ) {
            fail "$test: '$str' => '$expected'";
            note "Exception (with amnesty): ", $e =~ s/ at .*? line \d+.*$//r;
        }
    }
    note "";
}

done_testing;
