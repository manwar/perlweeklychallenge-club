#!/usr/bin/env bash
perl -lpe 's/(\d\d)(:\d\d)\s*([ap])m/sprintf "%02d$2", $1 + ($3 eq 'p' ? 12 : 0)/e || s/(\d\d)(:\d\d)\s*$/sprintf "%02d$2 %s", ($1 - 1) % 12 + 1, ($1 >= 12 ? "pm" : "am")/e'
