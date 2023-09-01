#!//bin/sh

raku -e 'say @*ARGS.grep({$_ != @*ARGS.min && $_ != @*ARGS.max}).join(q{, })||-1' "$@"