#!/bin/sh

perl -E 'my%a;for my$i(shift=~/(\d)/g){$a{$i}++}say[sort{$b<=>$a}keys %a]->[1]//-1' "$@"
