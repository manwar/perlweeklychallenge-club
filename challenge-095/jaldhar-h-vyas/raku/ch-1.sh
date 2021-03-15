raku -e 'say @*ARGS[0] eq @*ARGS[0].flip ?? 1 !! 0;' $@
