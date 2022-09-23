#!/usr/bin/env raku
use v6;
sub MAIN {
   my @list = [1,2], [3,4], [5,6], [1,2];
   .say for remove-duplicate-subarrays(@list);
}
sub remove-duplicate-subarrays (@a) { my %seen; @a.grep({!%seen{.gist}++}) }
