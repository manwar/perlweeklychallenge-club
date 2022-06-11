#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use FindBin '$Bin';
use lib "$Bin/local/lib/perl5";
use Lingua::EN::Numbers 'num2en';
map { say } ebans_upto(shift // 100);
sub ebans_upto ($max) { grep {num2en($_) !~ /e/i } 1 .. $max };
