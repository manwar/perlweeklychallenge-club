use strict;
use warnings;

use feature 'say';

#Common substring in 2 strings
use String::LCSS_XS 'lcss';

my ( $str1, $str2 ) = @ARGV;

die "Script require 2 strings as an arguments\n" unless @ARGV;

my $res = lcss ( $str1, $str2 );

say $res;
