#!/usr/bin/env raku
use v6;
sub MAIN (*@sentences) { put @sentences».split(/\s+/)».elems.max }
