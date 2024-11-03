#!/bin/sh

perl -E 'my %a;for(map{join q{},sort split q{ }} @ARGV){$a{$_}++};say [sort values %a]->[-1]' "$@"
