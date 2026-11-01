#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

say join " " =>
    map   {$$_ [0]}
    sort  {$$a [1] <=> $$b [1] || $$a [0] <=> $$b [0]}
    map   {[$_ => oct "0b" . reverse sprintf "%b" => $_]} split for <>;

__END__
