#!/usr/bin/perl 
#===============================================================================
#
#         FILE: 2019_16_2.pl
#
#        USAGE: ./2019_16_2.pl
#
#  DESCRIPTION: Perl Weekly challenge w16 #2
#               Write a script to validate a given bitcoin address.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 07/02/2019 09:47:38 PM
#     REVISION: ---
#===============================================================================

use warnings;
use strict;
use feature qw{ say };
use WWW::Mechanize;

sub is_valid_bitcoin {
    my $test_id = shift;

    my $mech = WWW::Mechanize->new;
    $mech->get( 'https://cointools.org/valid-address-checker/?address=' . $test_id );

    return 'valid' if $mech->content =~ /is\h+a\h+valid\h+bitcoin\h+address/msx;
    return 'invalid';
}

# ----------- MAIN ----------

my $test_address = shift // die 'No bitcoin address passed';

say "$test_address address is " . is_valid_bitcoin($test_address);

# ----------- TESTS ----------
use Test::More;

is( is_valid_bitcoin('1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2'),
    'valid', 'test valid 1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2' );
is( is_valid_bitcoin('3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy'),
    'valid', 'test valid 3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy' );

is( is_valid_bitcoin('1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN3'),
    'invalid', 'test invalid 1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN3' );
is( is_valid_bitcoin('3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLi'),
    'invalid', 'test invalid 3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLi' );

done_testing();
