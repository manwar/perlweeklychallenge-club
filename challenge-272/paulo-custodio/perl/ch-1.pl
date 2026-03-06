#!/usr/bin/env perl

use Modern::Perl;

$_ = shift // "";
say s/\./[.]/gr;
