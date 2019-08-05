#!/usr/bin/perl 
#===============================================================================
#
#         FILE: 2019w25_2.pl
#
#        USAGE: ./2019w25_2.pl  
#
#  DESCRIPTION: Perl weekly challenge w25 - 2
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-013/
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 06/20/2019 09:06:41 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use 5.020;
use Data::Dumper;

my $max = shift // die 'No n passed';

my %f_cache;
my %m_cache;

my @f_result;
my @m_result;

push @f_result, 1;
push @m_result, 0;

$f_cache{0} = 1;
$m_cache{0} = 0;

sub f {
    my $n = shift;

    my $result = $n - $m_cache{$f_cache{$n-1}};

    push @f_result, $result;
    $f_cache{$n} = $result;
}

sub m {
    my $n = shift;

    my $result = $n - $f_cache{$m_cache{$n-1}};

    push @m_result, $result;
    $m_cache{$n} = $result;
}


for (1..$max-1) {
    &f($_);
    &m($_);

}

say 'F : '. join ",", @f_result;
say 'M : '. join ",", @m_result;


