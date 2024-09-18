use strict; use warnings; use Test::More tests=>10;

my $re_optional_sign = qr/ [-+]?                                                   /x;
my $re_exponent      = qr/ [Ee] $re_optional_sign \d+                              /x;
my $re_integer       = qr/ $re_optional_sign \d+                                   /x;
my $re_decimal_num   = qr/ $re_optional_sign (\d+\.? | \d*\.\d+ )                  /x;
my $re_number        = qr/ ^ ( $re_integer | $re_decimal_num ) ( $re_exponent )? $ /x;

my($true, $false) = (1, '');

is "1"       =~ $re_number  =>  $true;
is "a"       =~ $re_number  =>  $false;
is "."       =~ $re_number  =>  $false;
is "1.2e4.2" =~ $re_number  =>  $false;
is "-1."     =~ $re_number  =>  $true;
is "+1E-8"   =~ $re_number  =>  $true;
is ".44"     =~ $re_number  =>  $true;
is "π"       =~ $re_number  =>  $false;
is "007"     =~ $re_number  =>  $true;
is "0000000" =~ $re_number  =>  $true; #hm
