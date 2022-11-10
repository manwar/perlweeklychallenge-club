#!/usr/bin/env raku
use v6;
sub MAIN ($input = '1115') { decoded-list($input).join(', ').put }

sub decoded-list ($encoded) {
   my @atoms = $encoded.comb;
   my $first = @atoms.shift;
   my $n = 2 ** @atoms;
   return gather while --$n >= 0 {
      my @code = '%b'.sprintf($n).comb;
      @code.unshift(0) while @code < @atoms;
      @code.push(1); # final separator to close stuff
      my @sequence;
      my $current = $first;
      for ^@code -> $i {
         if @code[$i].Int > 0 { # separate, close and reopen if applicable
            my $decoded = decode-item($current) or last;
            @sequence.push: $decoded;
            if $i <= @atoms.end {
               $current = @atoms[$i];
            }
            else {
               take @sequence.join('');
               last;
            }
         }
         else { # merge with previous
            $current ~= @atoms[$i];
         }
      }
   };
}

sub decode-item ($item) {
   state @letter-at = (Nil, 'A' .. 'Z').flat;
   return if $item ~~ /^ 0/; # we consider this invalid
   return if $item.Int > @letter-at.end;
   return @letter-at[$item.Int];
}
