#!/bin/sh

 raku -e 'say (1 .. *).grep({ .is-prime })[10_000]'
