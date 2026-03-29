#!/bin/sh

perl -E '$s=shift;say scalar grep{!index($s, $_)}@ARGV' "$@"
