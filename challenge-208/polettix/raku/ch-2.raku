#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   my @dam = duplicate-and-missing(@args, %*ENV<SHORT_CIRCUIT>);
   put @dam ?? "({@dam.join(',')})" !! -1;
}

sub duplicate-and-missing (@list, $short-circuit is copy = Nil) {
   $short-circuit //= True;
   my ($duplicate, $missing, @retval);
   for 1 ..^ @list -> $i {
      if @list[$i] == @list[$i - 1] {
         die "too many duplicates ($duplicate, {@list[$i]})\n"
            if defined $duplicate;
         @retval.push: $duplicate = @list[$i];
      }
      elsif (@list[$i] == @list[$i - 1] + 2) {
         my $miss = @list[$i] - 1;
         die "too many missing ($missing, $miss)\n" if defined $missing;
         @retval.push: $missing = $miss;
      }
      elsif (@list[$i] != @list[$i - 1] + 1) {
         die "unexpected gap\n";
      }
      else {} # just a simple increment
      return @retval if @retval == 2 && $short-circuit;
   }
   return [] unless defined($duplicate);
   @retval.push(@list[*-1] + 1) unless @retval == 2;
   return @retval;
}
