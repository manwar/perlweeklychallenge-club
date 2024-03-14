#!/usr/bin/env raku
use lib $?FILE.IO.cleanup.parent;
use Pi1000;

# 004-1 This script outputs PI w/ digit count == its file size.

say Pi().substr( 0, $*PROGRAM.s + 1);
