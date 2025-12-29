#!/usr/bin/raku
use experimental :cached;

sub postfix:<!>($n) is cached { $n == 0 ?? 1 !! $n * postfix:<!>($n - 1) }

(^10).map({ state $sum = 0; $sum += $_! }).join(q{, }).say;
