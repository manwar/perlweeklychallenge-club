#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
for i in 1..20: echo (var t = ""; if i mod 3 == 0: t &= "fizz"; if i mod 5 == 0: t &= "buzz"; if t.len == 0: t = $i; t)
