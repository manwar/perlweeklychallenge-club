#!/usr/bin/env raku
use v6;



sub MAIN {
   my $field-text = q:to/END/;
x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x
END

   $field-text.put;

   my @field = $field-text.lines.map: {[.comb(/\S+/).List]};
   print-field(@field);
   ''.put;
   print-field(reveal-solution(@field));
}

sub print-field (@field) { @field.map: *.join(' ').put }

sub reveal-solution (@field) {
   # this will keep the "revealed" field
	my @retval;

   # we need address cells in the @retval grid, so we have to iterate
   # over indices of the input array instead of on the rows directly
	for 0 .. @field.end -> $ri {
      my @row := @field[$ri];

      # same for columns, we need the index and we get it in $ci
      for 0 .. @row.end -> $ci {

         # make sure that the element is initialized.
         @retval[$ri][$ci] //= 0;

         # after this, the only cell that is meaningful for us is the mine,
         # as we will "propagate" its effects on the surrounding cells.
         # This is efficient as long as there are *few* mines.
         next if @row[$ci] ne 'x';

         # if the input field has a mine, the output has one too
         @retval[$ri][$ci] = 'x';

         # now we iterate over the 3x3 grid centered as ($ri, $ci),
         # making sure to ignore the central position (which cannot
         # influence itself) and that we don't go beyond the limits
         # of the input field. $rd is a "delta" for rows.
         for -1, 0, 1 -> $rd {
            # This is a position in the output field that is influenced
            # by the mine we just found. Well, actually it's a row for
            # multiple positions.
            my $Ri = $ri + $rd;
            next if $Ri < 0 || $Ri > @field.end;

            # similarly we do for column indexes
            for -1, 0, 1 -> $cd {
               next unless $rd || $cd; # get rid of (0, 0)
               my $Ci = $ci + $cd;
               next if $Ci < 0 || $Ci > @row.end;
               @retval[$Ri][$Ci] //= 0; # initialize if necessary
               next if @retval[$Ri][$Ci] eq 'x'; # don't overwrite mines
               @retval[$Ri][$Ci]++; # increment close-by position
            }
         }
      }
	}
   return @retval;
}
