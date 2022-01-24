use strict;
use warnings;
use feature "say";

my @ebans = grep { ! /[135789]$/ and ! /[12789]\d/ } 1..99;
say "@ebans";
