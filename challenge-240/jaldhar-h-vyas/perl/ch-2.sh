#!/bin/sh

perl -E 'say q{(},(join q{, },map{@ARGV[$_]}@ARGV),q{)}' "$@"