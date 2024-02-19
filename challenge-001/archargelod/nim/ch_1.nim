#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import strformat

var Text = "Perl Weekly Challenge"

var count: int
for c in Text.mItems:
  if c == 'e':
    inc count
    c = 'E'

echo Text
echo &"number of letters e: {count}"
