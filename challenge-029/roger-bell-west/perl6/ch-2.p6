#! /usr/bin/perl6

use NativeCall;

our sub cpf(Str, Str --> int32) is native(sub{'libc.so.6'}) is symbol('printf') { * }

cpf("%s\n",'a string passed from perl6');