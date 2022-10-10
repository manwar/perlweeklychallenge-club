#!/bin/sh

perl -E 'shift=~/(..)(..)\.(..)(..)\.(..)(..)/; say join q{:}, @{^CAPTURE};' $@