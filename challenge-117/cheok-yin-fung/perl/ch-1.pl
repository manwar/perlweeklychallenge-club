while(<>) {/^\s*(\d+)/; $arr{$1} = 1;} for (1..15) {print ($_, "\n") unless $arr{$_};}
