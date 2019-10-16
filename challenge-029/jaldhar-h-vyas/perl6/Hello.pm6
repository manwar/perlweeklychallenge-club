use v6;
unit module Hello;

use NativeCall;

sub libhello is export {
    return '../c/libhello.so';
}

sub hello() is native(&libhello) is export {*};
