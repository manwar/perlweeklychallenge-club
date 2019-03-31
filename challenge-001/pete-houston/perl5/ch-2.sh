perl -E 'for (1..20) { my $o; $o .= "fizz " unless $_ % 3; $o .= "buzz" unless $_ % 5; $o //= $_; say $o; }'

