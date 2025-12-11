#!/usr/bin/env perl

use strict;
use warnings;

# my $str1 = "uvw";
# my $str2 = "bcudvew";

# my $str1 = "aec";
# my $str2 = "abcde";

my $str1 = "sip";
my $str2 = "javascript";

my $str1_prere = join( '.*', unpack( "(a)*", $str1 ) );
my $str1_re    = qr<$str1_prere>;

if ( $str2 =~ $str1_re ) {
    print "true\n";
}
else {
    print "false\n";
}
