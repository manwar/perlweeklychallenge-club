perl6 -e 'loop { my $d = DateTime.now; printf "\r%02d:%02d:%02d", $d.hour, $d.minute, $d.second; sleep 1;'
