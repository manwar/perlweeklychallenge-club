#!/bin/sh
raku -e 'say @*ARGS[0] +^ (1 +< (@*ARGS[1] - 1));' $@
