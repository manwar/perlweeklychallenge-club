#!/usr/bin/env raku
use v6;
sub MAIN (*@n) { put sb(|@n) }

multi sub sb  ()            { 0                         }
multi sub sb  ($n)          { $n                        }
multi sub sb  ($n, $m)      { $n +& $m                  }
multi sub sb  ($n, *@r)     { sbf($n, |@r) + sb(|@r)    }
multi sub sbf ($n, $m)      { sb($n, $m)                }
multi sub sbf ($n, $m, *@r) { sb($n, $m) + sbf($n, |@r) }
