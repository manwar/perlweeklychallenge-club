#!/usr/bin/env perl

use Modern::Perl;

$_ = shift // "";
say /b/ && !/^[^b]*b.*?a/ ? 'true' : 'false';
