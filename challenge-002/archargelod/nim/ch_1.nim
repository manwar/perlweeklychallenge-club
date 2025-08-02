#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import strutils

var Number = "000012312"
Number.removePrefix('0')
echo Number
