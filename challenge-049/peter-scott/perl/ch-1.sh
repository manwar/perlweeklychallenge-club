#!/bin/sh
perl -E '$x = shift; $i = 1; $i++ until ($i*$x) =~ /^[01]+$/; say "$i * $x = ", $i*$x' $*
