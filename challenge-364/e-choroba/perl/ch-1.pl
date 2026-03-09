#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

my %TRANSLATE;
my $i = 1;
my $c = 'a';

$TRANSLATE{$i++}         = $c++ for  1 ..  9;
$TRANSLATE{ $i++ . '#' } = $c++ for 10 .. 26;

sub decrypt_string($str) {
    $str =~ s/((?:1[0-9]|2[0-6])#|[0-9])/$TRANSLATE{$1}/gr
}

use Test::More tests => 5 + 1;

is decrypt_string('10#11#12'), 'jkab', 'Example 1';
is decrypt_string('1326#'), 'acz', 'Example 2';
is decrypt_string('25#24#123'), 'yxabc', 'Example 3';
is decrypt_string('20#5'), 'te', 'Example 4';
is decrypt_string('1910#26#'), 'aijz', 'Example 5';

is decrypt_string(""), "", 'Empty';
