#!/bin/sh

perl -E 'my $s=0,@a=@ARGV;for(@a[$a[-2]..$a[-1]]){$s+=$_};say $s' "$@"
