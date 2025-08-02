#!/usr/bin/env -S perl -lp
$_=/\b(\w+)\W*\z/?length$1:0
