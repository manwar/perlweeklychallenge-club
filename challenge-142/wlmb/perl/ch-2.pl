#!/usr/bin/env perl
# Perl weekly challenge 142
# Task 2: sleep sort
#
# See https://wlmb.github.io/2021/12/09/PWC142/#task-2-sleep-sort
use v5.12;
use warnings;
use Time::HiRes qw(sleep time);
use POSIX ":sys_wait_h";
my %value_for_kid;
my @ordered;
say("Usage: ./ch-2.pl scale a b c...\nto sort the numbers a b c...\n".
    "   Uses sleep sort. Sleep time is scale*number seconds"),
    exit if @ARGV<=1;
my $scale=shift @ARGV;
foreach(@ARGV){
    my $pid=fork;
    die "couldn't fork" unless defined $pid;
    if($pid==0){
	sleep($scale*$_);
	exit 0;
    }
    $value_for_kid{$pid}=$_;
}

while ((my $pid = waitpid(-1, 0))>0){
    push @ordered, $value_for_kid{$pid};
}

say "\nInput: ", join ", ", @ARGV;
say "Scale: $scale";
say "Output: ", join ", ", @ordered;
