#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

use Template::Perlish;

my $input = shift // "53,10\n53,10,23,30\n23,30";
say svg_for($input);

sub svg_for ($text) {
   state $tp2 = Template::Perlish->new->compile_as_sub(
q{<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="400" width="400" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
[% for my $item (A 'lines') {
      if ($item->@* == 2) {
%] <circle r="4" cx="[%= $item->[0] %]" cy="[%= $item->[1] %]" stroke-width="0" fill="#000000" />
[%    } else {
%] <polyline points="[%= join ' ', $item->@* %]" stroke="#ff0000" stroke-width="6" />
[%    }
   }
%]</svg>});
   $tp2->({lines => [map {[ split m{,+}mxs ]} split m{\n+}mxs, $text]});
}
