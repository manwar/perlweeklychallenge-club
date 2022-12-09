#!/bin/env raku

unit sub MAIN(Str:D \tms);

put (9...0).first({
    try { "2022-02-22T{ tms.trans('?' => ~$_) }:00Z".DateTime }
    $_ unless $!
});
