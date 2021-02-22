perl -e 'shift=~/(\d+):(\d\d\s*((am|pm)))/;if($1 < 12 && $3 eq "pm"){$h = $1 + 12}elsif($1 > 12 && $3 eq "pm"){$h = "0" . ($1 - 12)}else{$h = $1}print "$h:$2\n"' "17:15 pm"
