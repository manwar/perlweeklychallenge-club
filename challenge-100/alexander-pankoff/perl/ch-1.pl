#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

## As a oneliner:
## perl -e 'join(" ",@ARGV)=~m/^\s*(\d\d?)\:(\d\d?)\s*([ap]m)?\s*$/&&printf("%02d\:%02d%s\n",$3?($3eq"pm"?$1==12?12:$1+12:$1==12?0:$1,$2,""):$1>=12?($1==12?12:$1-12,$2,"pm"):($1==0?12:$1,$2,"am"))' TIME
{
    if ( $ENV{TESTING} ) {
        test_convert_time();
    }
    else {
        my ($T) = join( ' ', @ARGV );
        die "usage: $0 TIMESTRING\n" unless length $T;

        say convert_time($T);
    }
}

sub test_convert_time() {

    my @test_cases = (
        [ "05:15 pm", "17:15" ],
        [ "05:15pm",  "17:15" ],
        [ "19:15",    "07:15pm" ],
        [ "19:15",    "07:15pm" ],
        [ "9:15",     "09:15am" ],
        [ "9:15am",   "09:15" ],
        [ "9:1am",    "09:01" ],
        [ "12:00am",  "00:00" ],
        [ "00:00",    "12:00am" ],
        [ "12:00",    "12:00pm" ],
        [ "00:30",    "12:30am" ],
        [ "12:00am",  "00:00" ],
        [ "12:30am",  "00:30" ],
    );

    require Test::More;
    Test::More->import( tests => 2 * scalar @test_cases );

    for my $test (@test_cases) {
        my ( $time, $converted ) = @{$test};
        ok( convert_time($time) eq $converted,
            "$time converted to $converted" );
        ok(
            convert_time_oneliner($time) eq $converted,
            "$time converted to $converted with oneliner"
        );
    }

}

sub convert_time_oneliner($time) {
    my $oneliner =
'join(" ",@ARGV)=~m/^\s*(\d\d?)\:(\d\d?)\s*([ap]m)?\s*$/&&printf("%02d\:%02d%s\n",$3?($3eq"pm"?$1==12?12:$1+12:$1==12?0:$1,$2,""):$1>=12?($1==12?12:$1-12,$2,"pm"):($1==0?12:$1,$2,"am"))';
    my $out = `perl -e '$oneliner' $time`;
    chomp($out);
    return $out;
}

sub convert_time($time) {
    if (
        $time =~ m/
                      ^         # anchor to the beginning of the string
                      \s*       # allow leading whitespace
                      (\d\d?) # the hour part
                      \:        # match the colon
                      (\d\d?) # the minute part
                      \s*       # optional whitespace
                      (am|pm)?  # optional am or pm
                      \s*       # allow trailing ws
                      $         # anchor to the end of the string
                     /x
      )
    {
        sprintf(
            "%02d\:%02d%s",
            $3 ? (
                $3 eq 'pm'    #
                ? $1 == 12
                      ? 12
                      : $1 + 12
                : $1 == 12 ? 0
                : $1,
                $2, ''
              )
            : $1 >= 12        #
            ? ( $1 == 12 ? 12 : $1 - 12, $2, 'pm' )
            : ( $1 == 0 ? 12 : $1, $2, 'am' )
        );
    }
}
