#!/bin/sh
perl -E '$N=shift; @R=(0)x$N; for $e (1..$N){ for ($r = $e; $r < $N; $r += $e ) { $R[$r-1] ^= 1 } } say for grep { $R[$_-1] } 1..$N' 500

