perl -le 'for (1..20){print $_%15?($_%3?($_%5?"$_":"buzz"):"fizz"):"fizz buzz"}'
