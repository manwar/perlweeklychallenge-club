#!/usr/bin/env perl
# Perl weekly challenge 231
# Task 2:  Senior Citizens
#
# See https://wlmb.github.io/2023/08/20/PWC231/#task-2-senior-citizens
use v5.36;
my $form="9999999999A1122";
$form=~s/[9A2]/./g;     # Change form into a RE to obtain age. Change 9, A and 2 to any
$form=~s/(1+)/($1)/;    # Capture  1's
$form=~s/1/\\d/g;       # Change 1's to digits
$form=~s/^(.*)$/^$1\$/; # Add anchors
my $re=qr /$form/;
say "@ARGV -> ", 0+grep {/^...........(\d\d)..$/||die "Wrong format: $_"; $1>=60} @ARGV;
