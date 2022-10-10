#!/usr/bin/env perl
# Perl weekly challenge 186
# Task 2:  Unicode Makeover
#
# See https://wlmb.github.io/2022/10/10/PWC186/#task-2-unicode-makeover
use v5.36;
use Encode qw(decode encode);
use Unicode::Collate;
sub char2ascii($char){ # Convert single char to ascii
    state $coll=Unicode::Collate->new(level=>3, ignore_level2=>1); #Ignore accents, check case
    state @ascii=("a".."z", "A".."Z", "0".."9");
    $coll->cmp($_, $char)==0 && return $_ for @ascii; #return ascii if found
    $char # default
}

sub makeover($string){ # convert string to ascii
    join "", map {char2ascii $_} split "", $string
}

die "Usage: $0 S1 [S2...]\nto convert strings S1 S2 etc. to ascii" unless @ARGV;
say encode("UTF-8", makeover(decode("UTF-8", $_))) for(@ARGV);
