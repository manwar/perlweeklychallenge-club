#! /usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package My::LZW;

    my $LAST = 26;
    my %DICTIONARY;
    @DICTIONARY{'A' .. 'Z'} = 1 .. $LAST;
    my $REGEX = join '|', 'A' .. 'Z';

    sub encode {
        my ($input) = @_;
        my $last = $LAST;
        my $regex = $REGEX;
        my %dictionary = %DICTIONARY;

        my @encoded;
        while ($input =~ /($regex)(?=(.?))/g) {
            my ($known, $next) = ($1, $2);
            if (! exists $dictionary{"$known$next"}) {
                $dictionary{"$known$next"} = ++$last;
                substr $regex, 0, 0, "$known$next|";
            }
            push @encoded, $dictionary{$known};
        }
        return \@encoded
    }

    sub decode {
        my @encoded = @_;
        my $last = $LAST;
        my $regex = $REGEX;
        my %dictionary = reverse %DICTIONARY;

        my $decoded;
        while (my $code = shift @encoded) {
            my $next = $dictionary{ $encoded[0] // "" } // $dictionary{$code};
            $dictionary{++$last} = $dictionary{$code} . substr $next, 0, 1;
            $decoded .= $dictionary{$code};
        }

        return $decoded
    }
}

use Test::More tests => 2;

my $string = 'TOBEORNOTTOBEORTOBEORNOT';
my @encoded = @{ My::LZW::encode($string) };
my $decoded = My::LZW::decode(@encoded);

is_deeply \@encoded, [qw[ 20 15 2 5 15 18 14 15 20 27 29 31 36 30 32 34 ]];
is $string, $decoded;
