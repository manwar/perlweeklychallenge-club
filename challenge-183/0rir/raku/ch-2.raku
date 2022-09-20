#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
Task 183-2: Date Difference     Submitted by: Mohammad S Anwar
Given two dates, $date1 and $date2 in the format YYYY-MM-DD,
yield, as text, the difference between the dates in terms of
years and days.
Example
Input: $date1 = '2019-02-10'
       $date2 = '2022-11-01'
Output: 3 years 264 days
=end comment

# NOTE:  Expressing differences as unsigned values.

constant TEST=True;
if TEST {
    my @Test =
        { dates => ( '2019-09-15', '3921-09-16' ), exp => '1902 years 1 day' },
        { dates => ( '2019-02-10', '2022-11-01' ), exp => '3 years 264 days'},
        { dates => ( '2020-09-15', '2022-03-29' ), exp => '1 year 195 days' },
        { dates => ( '2019-12-31', '2020-01-01' ), exp => '1 day'           },
        { dates => ( '2019-12-01', '2019-12-31' ), exp => '30 days'         },
        { dates => ( '2019-12-31', '2020-12-31' ), exp => '1 year'          },
        { dates => ( '2019-12-31', '2021-12-31' ), exp => '2 years'         },
        { dates => ( '2020-09-15', '2021-09-16' ), exp => '1 year 1 day'    },
        { dates => ( '2019-09-15', '2021-09-16' ), exp => '2 years 1 day'   },
        { dates => ( '2021-09-16', '2021-09-16' ), exp => '0 days'          },
        { dates => ( '2019-09-15', '3921-09-16' ), exp => '1902 years 1 day' },
    ;
    my @Death = { dates => ( '3921-09-16', '2019-09-15' ) };
    plan @Test.elems;
    for @Test -> %t {
        my $got = iso-datestr-diff( %t<dates>[0], %t<dates>[1]),
        is $got, %t<exp>,
            "describe duration %t<dates>[0] to %t<dates>[1] as %t<exp>";
    }
    done-testing;
    exit;
}

my %noun-form-database;

multi sub iso-datestr-diff( Str:D $a, Str:D $b --> Str:D ) {
    my Str ($days, $years);
    my %yd = iso-datestr-diff( $a, $b, :hash );

    return "0 days"  if 0 == %yd{ <year day> }.all;

    if not %yd<day> {
        return %yd<year> ~ ' ' ~ noun-form( 'year', %yd<year> );
    }
    if not %yd<year> {
        return %yd<day> ~ ' ' ~ noun-form( 'day', %yd<day> );
    }
    return  %yd<year> ~ ' ' ~ noun-form( 'year', %yd<year> )
          ~ ' ' ~ %yd<day> ~ ' ' ~ noun-form( 'day', %yd<day> );
}

multi sub iso-datestr-diff( Str $a, Str $b, Bool :$hash! --> Hash ) {
    my ($yrs, $days) = 0,0;
    my ($x, $y) = sort Date.new( $a), Date.new( $b);

    while $x.later( years => 1 ) ≤ $y { $x.=later( year => 1); $yrs++ }
    while $x.later(  days => 1 ) ≤ $y { $x.=later( day => 1); $days++ }
    return { year => $yrs, day => $days};
}

# $noun's grammatical number per $ct.  Expects singular form.
sub noun-form( Str:D $noun, Int:D $ct where * ≥ 0 --> Str ) {
    if %noun-form-database{$noun}:exists {
        die "Noun-form-database use is NYI.";
    }
    return  $noun if $ct == 1;
    return $noun ~ 's';
}

sub MAIN( $date1 = '2019-09-15', $date2 = '3921-09-16' ) {
    say "Input: \$date1 = $date1
       \$date2 = $date2";
    say "Output: iso-datestr-diff( $date1, $date2)";
}
