#!/bin/sh

perl -E 'say join q{-},(map{sprintf"%b",$_}split/-/,shift)' "$@"
