perl -E 'shift=~/(\d+):(\d\d\s*(am|pm))/; $h=($1 < 12)?$1 + 12: $1; print "$h:$2\n"' "05:15 pm"
