#!/usr/bin/perl
use warnings;
use strict;
use Syntax::Construct qw{ // };

use List::Util qw{ sum };

my %TRANSLITERATION = qw( A 1 B 2 C 3 D 4 E 5 F 6 G 7 H 8 J 1 K 2 L 3
                          M 4 N 5 P 7 R 9 S 2 T 3 U 4 V 5 W 6 X 7 Y 8 Z 9 );

my @WEIGHTS = qw( 8 7 6 5 4 3 2 10 0 9 8 7 6 5 4 3 2 );

sub check_digit {
    my ($vin) = @_;
    my @w = @WEIGHTS;
    my $remainder = sum(map shift(@w) * ($TRANSLITERATION{$_} || $_),
                        split //, $vin
                    ) % 11;
    $remainder = 'X' if 10 == $remainder;
    return $remainder eq substr $vin, 8, 1
}

# Use "North America" or "China" as the second argument if the vehicle
# is being sold to one of those regions.
sub validate_vin {
    my ($vin, $sold) = @_;
    $sold //= "";

    die 'Invalid length or character' if $vin !~ /^[0-9A-HJ-NPR-Z]{17}$/;

    die 'Invalid country code'
        if $vin =~ /^(?:A[P-Z0-9]|[BCD][S-Z0-9]|[EF][L-Z0-9]|[GH]
                    |[NP][S-Z0-9]|S[05-9]
                    |T[02-9]|U[01-489A-G]|Z[06-9S-W]
                    |[39]0|8[03-9]
                    )/x;

    die 'Invalid North American VIS'
        if $sold eq 'North America' && $vin !~ /^.{12}[0-9]{5}/;

    die 'Invalid year' if $vin =~ /^.{9}[UZ0]/;

    die 'Invalid check' if ($sold eq 'North America' || $sold eq 'China')
                        && ! check_digit($vin);
}

use Test::More tests => 19;
use Test::Exception;

throws_ok { validate_vin('1' x 18) } qr/Invalid length/, 'too long';
throws_ok { validate_vin('1' x 16) } qr/Invalid length/, 'too short';

throws_ok { validate_vin('O' . '1' x 16) }
          qr/Invalid.*character/, 'capital O';
throws_ok { validate_vin('I' . '1' x 16) }
          qr/Invalid.*character/, 'capital I';
throws_ok { validate_vin('Q' . '1' x 16) }
          qr/Invalid.*character/, 'capital Q';

lives_ok { validate_vin('1G145678XABCX2345') } 'valid outside NA';
throws_ok { validate_vin('1G145678XABCX2345', 'North America') }
          qr/North American VIS/, 'NA vis';

throws_ok { validate_vin('111111111U1111111') }
          qr/Invalid year/, 'invalid year';

lives_ok { validate_vin('1' x 17) } 'straight-ones';
lives_ok { validate_vin('1M8GDM9AXKP042788') } 'hypothetical';
lives_ok { validate_vin('1M8GDM9AXKP042788', 'North America') }
    'hypothetical NA';
lives_ok { validate_vin('5GZCZ43D13S812715') } 'valid exmple';
lives_ok { validate_vin('5GZCZ43D13S812715', 'North America') }
    'valid NA exmple';

lives_ok { validate_vin('SGZCZ43D13S812715') } 'outside NA and China';
throws_ok { validate_vin('SGZCZ43D13S812715', 'China') }
          qr/check/, 'invalid check';

lives_ok { validate_vin('WP0ZZZ99ZTS392124') } 'outside NA and China';
throws_ok { validate_vin('WP0ZZZ99ZTS392124', 'China') }
          qr/check/, 'invalid check';

lives_ok { validate_vin('KLATF08Y1VB363636') } 'outside NA and China';
throws_ok { validate_vin('KLATF08Y1VB363636', 'China') }
          qr/check/, 'invalid check';
