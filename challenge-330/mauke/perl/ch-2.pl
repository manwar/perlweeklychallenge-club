#!/usr/bin/env -S perl -p
#s{\w+}{ length($&) > 2 ? "\u\L$&" : "\L$&" }eg
$_=lc;s/\w{3,}/\u$&/g
