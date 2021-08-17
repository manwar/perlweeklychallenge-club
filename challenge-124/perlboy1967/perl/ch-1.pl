#!/usr/bin/perl

# Perl Weekly Challenge - 124
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-124/#TASK1
#
# Task 1 - Happy Women Day
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Compress::Zlib;
use MIME::Base64;

print uncompress 
      decode_base64
      q/eJxTUFBQiAMBLhBDAQRATAgLzIYxyeYgG4ZsB5LFcBF0GrsKANslHl8=/;

