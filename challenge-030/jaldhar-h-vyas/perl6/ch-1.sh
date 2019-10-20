perl6 -e '"$_-12-25".say for (2019..2100).grep({Date.new($_,12,25).day-of-week==0;});'
