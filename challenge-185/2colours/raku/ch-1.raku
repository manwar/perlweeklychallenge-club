#!/usr/bin/env raku

my token four-hexa { <xdigit> ** 4 }

my $input = prompt 'Input: ';
$input .= trim;
die 'Please provide a valid hhhh.hhhh.hhhh MAC address!' unless $input ~~ / ^ <four-hexa> '.' <four-hexa> '.' <four-hexa> $ /;
print 'Output: ';
[~] $<four-hexa> andthen
  .comb: / . ** 2 / andthen
  .join: ':' andthen
  .say; 