#!/usr/bin/env perl

use v5.38;

sub rev_prefix { $_[0] =~ s/^(.+?\Q$_[1]\E)/reverse $1/er }

say rev_prefix(@ARGV) if @ARGV == 2;
