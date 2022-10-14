#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use Unicode::UCD 'charinfo';
use utf8;

say makeover('âÊíÒÙ whatever123 ÃÊÍÒÙ');

sub makeover ($str) {
   return join '', map {
      my $info = charinfo(ord $_);
      my ($basic_hex) = split m{\s+}mxs, $info->{decomposition};
      my $basic = hex($basic_hex // '00');
      my $is_latin_letter =
         (ord('a') <= $basic && $basic <= ord('z'))
         || (ord('A') <= $basic && $basic <= ord('Z'));
      $is_latin_letter ? chr($basic) : $_;
   } split m{}mxs, $str;
}
