$var = <STDIN>;
my ($h, $m) = ($var =~ /(\d+):(\d+)/);
$' =~ /pm/ ? print (($h + 12).":$m") : ($' !~ /am/ ? ($h >= 12 ? print (($h - 12) . ":$m pm") : print "$h:$m am") : print "$h:$m");
