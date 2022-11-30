raku -e 'sub MAIN ($n) { printf "%03b ", $_ for 0..2**$n-1; }' 3
echo
raku -e 'sub MAIN ($n) { printf "%03b ", $_ for 0..2**$n-1; }' 4
echo
