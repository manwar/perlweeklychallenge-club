#!/bin/sh

raku -e '(S:g/\D/ / given @*ARGS[0]).trim.split(/\s+/).unique.join(q{, }).say' "$@"
