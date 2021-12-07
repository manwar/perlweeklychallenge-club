#!/usr/bin/perl

# TASK #2 > Sleep Sort
# Submitted by: Adam Russell
# Another joke sort similar to JortSort suggested by champion Adam Russell.
#
# You are given a list of numbers.
#
# Write a script to implement Sleep Sort. For more information, please checkout
# this post.

use Modern::Perl;
use Config;
use threads;

sub sleeper {
    my($n) = @_;
    sleep $n;
    say $n;
}

my @thrs;
push @thrs, threads->create(\&sleeper, $_) for @ARGV;
$_->join() for @thrs;
