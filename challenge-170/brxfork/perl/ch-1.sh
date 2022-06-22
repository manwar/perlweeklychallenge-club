#!/bin/sh
 perl -E 'while(@p < 10) { $_.="x";/^(.{2,})\1+$/ or push @p,($p[-1]//1)*length};say "@p"'
