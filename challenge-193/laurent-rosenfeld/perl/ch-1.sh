perl -e 'my $c = shift; printf "%0${c}b ", $_ for 0..(2**$c) - 1' 3
echo
perl -e 'my $c = shift; printf "%0${c}b ", $_ for 0..(2**$c) - 1' 4
echo
