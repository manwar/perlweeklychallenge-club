#!/usr/bin/env perl6

use NativeCall;
sub getuid() returns uint32   is native { * };
put getuid;
