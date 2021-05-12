#! /usr/bin/env perl

# Canonical UNIX path
#
# one-liner versions:
# -E'$_=pop;s#/\.?(?=(/|$))##g;1while s#/([^/]+/)?\Q..##;say$_||"/"'
# -E'$_=pop;s#/\.?(?=(/|$))##g;{s#/([^/]+/)?\Q..##&&redo}say$_||"/"'

use v5.22;
use warnings;

$_ = shift;

# squeeze /s + remove final ones and get rid of /./
s#/\.?(?=(/|$))##gn;

# discard /dir/.. occurrences from path
1 while s#/([^/]+/)?\Q..##n;
# { redo if s#/([^/]+/)?\Q..##n }

say $_||'/'
