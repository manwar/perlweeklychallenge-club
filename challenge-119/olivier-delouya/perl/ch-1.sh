perl -e 'print $_, " => ", (($_ & 0x0f) << 4) | (($_ & 0xf0) >>4), "\n" foreach (@ARGV)' -- 101 18
