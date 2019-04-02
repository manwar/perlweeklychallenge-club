my @numbers = <01 002 000 008 0234 55 03 1780>; #test cases for reference
for @numbers  {
say "0" and next unless $_ ~~ /<-[0]> +/; #in case of zero(es)
$_ ~~ /^^0+/ ?? say $/.postmatch !! put $_;
}
