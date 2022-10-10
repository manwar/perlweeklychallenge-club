#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       mac-attack.pl
#
#       MAC Address
#         Submitted by: Mohammad S Anwar
#         You are given MAC address in the form i.e. hhhh.hhhh.hhhh.
# 
#         Write a script to convert the address in the form hh:hh:hh:hh:hh:hh.
# 
#         Example 1
#             Input:  1ac2.34f0.b1c2
#             Output: 1a:c2:34:f0:b1:c2
#         Example 2
#             Input:  abc1.20f1.345a
#             Output: ab:c1:20:f1:34:5a
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

sub cvt_mac ( $str ) {  

    $str =~ s/\./:/g;
    $str =~ s/([a-fA-F00-9]{2})([a-fA-F00-9]{2})/$1:$2/g;
    
    return $str;
}



use Test::More;

is cvt_mac( '1ac2.34f0.b1c2' ), '1a:c2:34:f0:b1:c2', 'ex-1';
is cvt_mac( 'abc1.20f1.345a' ), 'ab:c1:20:f1:34:5a', 'ex-2';

done_testing();
