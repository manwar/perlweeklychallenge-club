#!/usr/bin/perl

use v5.40;

open my $f, '<', $0;
undef $/;
@_ = split /\s+/, <$f>;
say $_[ int rand @_ ];
