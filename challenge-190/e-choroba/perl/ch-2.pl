#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';
use Memoize;

my %to_char = ("" => "",
               map { $_ => chr $_ - 1 + ord 'A'} 1 .. 26);
memoize('decoded_list');
sub decoded_list ($digits) {
    return [] if '0' eq substr $digits, 0, 1;

    return [$to_char{$digits}] if 1 >= length $digits;

    return [map {
        my $prefix = $_;
        map $to_char{$prefix} . $_,
            @{ decoded_list(substr($digits, length $prefix)) }
    } grep exists $to_char{$_},
           map substr($digits, 0, $_), 1, 2]
}

use Test2::V0;
plan 3 + 4;

is decoded_list('11'), [qw[ AA K ]], 'Example 1';
is decoded_list('1115'), [qw[ AAAE AAO AKE KAE KO ]], 'Example 2';
is decoded_list('127'), [qw[ ABG LG ]], 'Example 3';

is decoded_list(""), [""], 'Empty';
is decoded_list('01'), [], 'Initial zero';
is decoded_list('101'), ['JA'], 'Later zero';  # No /^A/.
is decoded_list('1001'), [], 'Later zeros';    # 00 can't be decoded.
