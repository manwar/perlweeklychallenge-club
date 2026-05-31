#!/bin/sh

perl -E 'my($n,$k)=@ARGV;say scalar grep{!($n%$_)}map{substr $n,$_,$k}0..(length $n)-$k' "$@"
