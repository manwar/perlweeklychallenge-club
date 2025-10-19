#!/usr/bin/env perl

use v5.38;
use List::Util qw< min >;

sub zero_friend { min map abs, @_ }
