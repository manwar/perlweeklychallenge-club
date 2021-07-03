#!/usr/bin/env perl
# Perl weekly challenge 119
# Task 2: sequence without 1-on-1
#
# See https://wlmb.github.io/2021/06/28/PWC119/#task-2-sequence-without-1-on-1

use strict;
use warnings;
use v5.12;
use integer;

map {say "Input: $_, Output: ", get($_)} @ARGV;
sub get {
    my $want=shift;
    my $r="1";
    $r=increment($r) while($r=~/11/ || --$want > 0);
    $r;
}
sub increment {
    my $r=shift;
    while(1){
	$r=~/(.*)(.)$/;
	my $high=$1||0;
	my $low=$2+1;
	return $low>3?increment($high)."1":$high?$high.$low:$low;
    }
}
