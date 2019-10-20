#!/usr/bin/env perl6
use v6;

use NativeCall;

sub MAIN(UInt:D $seconds = 2) {
    my $ret = native-sleep($seconds);
    say "Sleep returned a value of $ret";
}

# This will fail on 32 bit environments, you can't use "uint" for types
# unfortunately.  But if someone knows a workaround so you don't have to
# specify length (just use native C lengths), I'd love to hear that.
my sub native-sleep(uint64 -->uint64) is native is symbol('sleep') { * }

