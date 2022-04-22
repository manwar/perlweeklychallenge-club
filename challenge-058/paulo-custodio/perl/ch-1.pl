#!/usr/bin/env perl

# Challenge 058
#
# TASK #1 › Compare Version
# Reviewed by Ryan Thompson
# Compare two given version number strings v1 and v2 such that:
#
# If v1 > v2 return 1
# If v1 < v2 return -1
# Otherwise, return 0
# The version numbers are non-empty strings containing only digits, and the dot
# (“.”) and underscore (“_”) characters. (“_” denotes an alpha/development
# version, and has a lower precedence than a dot, “.”). Here are some examples:
#
#    v1   v2    Result
# ------ ------ ------
#   0.1 < 1.1     -1
#   2.0 > 1.2      1
#   1.2 < 1.2_5   -1
# 1.2.1 > 1.2_1    1
# 1.2.1 = 1.2.1    0
# Version numbers may also contain leading zeros. You may handle these how you
# wish, as long as it’s consistent.

use Modern::Perl;
use version;

my($a, $b) = @ARGV;
my $v1 = version->parse($a);
my $v2 = version->parse($b);
say $v1<$v2? -1 : $v1>$v2 ? 1 : 0;
