#!/bin/sh
perl -E 'for (@ARGV){$s+=$_; print $s/++$n, ", "} say " ..."' $*
