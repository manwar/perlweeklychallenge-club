#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   @args = 1, 5, 1, 1, 6, 4 unless @args;
   put '(', wiggle-sort-sloppy(@args).join(','), ')';
}

sub wiggle-sort-sloppy (@list) {
   my @ordered = @list.sort: { $^a <=> $^b };
   my $halfway = (@ordered + 1) div 2;
   gather for ^$halfway {
      take @ordered[$_];
      take @ordered[$_ + $halfway] if $_ + $halfway < @ordered;
   }
}
