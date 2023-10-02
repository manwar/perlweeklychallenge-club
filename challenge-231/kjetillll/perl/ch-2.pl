
sub seniors { 0 + grep /[6-9]...$/, @_ }

print seniors(@ARGV), "\n";
