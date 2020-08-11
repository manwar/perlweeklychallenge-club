
perl -F// -e 'map { $_ => ++$s{$_} } grep {/[a-zA-Z]/} @F;' -e 'END{ for(keys %s) { print "$_:$s{$_}\n";} }' example.txt example.txt

