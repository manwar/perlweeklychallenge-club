use strict;
use warnings;
use feature "say";

while ($_ = shift and @ARGV >= 1) {
    last unless fork;
}
sleep $_;
say;
wait;
