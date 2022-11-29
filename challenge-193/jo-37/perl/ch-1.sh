#!/bin/sh
perl -se 'printf "%0${n}b\n", $_ for 0..2**$n-1' -- -n=$1
