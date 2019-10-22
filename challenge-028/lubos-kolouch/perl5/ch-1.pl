#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-028/
#
#  Write a script to check the file content without explicitly reading the content. It should accept file name with path as command line argument and print “The file content is binary.” or else “The file content is ascii.” accordingly.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 09/30/2019 01:20:02 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;

sub get_file_status {
    my $file = shift;

    return "The file does not exist." unless -e $file;

    return "The file is not readable." unless -r $file;

    return "The file is empty." if -z $file;

    return "The file is not regular." unless -f $file;

    return "The file content is ascii." if -T $file;

    return "The file content is binary.";
}

my $file = shift || die 'Usage: ch-1.pl filename';

say get_file_status($file);

# TESTS

use Test::More;

is (get_file_status('ch-1.pl'),'The file content is ascii.');
is (get_file_status('.'),'The file is not regular.');
is (get_file_status('/dev/zero'),'The file is empty.');
is (get_file_status('ch-3.pl'),'The file does not exist.');
is (get_file_status('/etc/shadow'),'The file is not readable.');

done_testing;
