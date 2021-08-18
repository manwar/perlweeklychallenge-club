#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my $field_text = <<'END';
x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x
END

my $field = [map { [split m{\s+}mxs] } split m{\n}mxs, $field_text];

print_field($field);
say '';
print_field(reveal_solution($field));

sub print_field ($field) { say join ' ', $_->@* for $field->@* }

sub reveal_solution ($field) {
   # this will keep the "revealed" field
	my @retval;

   # we need address cells in the @retval grid, so we have to iterate
   # over indices of the input array instead of on the rows directly
	for my $ri (0 .. $field->$#*) {
      my $row = $field->[$ri];

      # same for columns, we need the index and we get it in $ci
      for my $ci (0 .. $row->$#*) {

         # make sure that the element is initialized.
         $retval[$ri][$ci] //= 0;

         # after this, the only cell that is meaningful for us is the mine,
         # as we will "propagate" its effects on the surrounding cells.
         # This is efficient as long as there are *few* mines.
         next if $row->[$ci] ne 'x';

         # if the input field has a mine, the output has one too
         $retval[$ri][$ci] = 'x';

         # now we iterate over the 3x3 grid centered as ($ri, $ci),
         # making sure to ignore the central position (which cannot
         # influence itself) and that we don't go beyond the limits
         # of the input field. $rd is a "delta" for rows.
         for my $rd (-1, 0, 1) {
            # This is a position in the output field that is influenced
            # by the mine we just found. Well, actually it's a row for
            # multiple positions.
            my $Ri = $ri + $rd;
            next if $Ri < 0 || $Ri > $field->$#*;

            # similarly we do for column indexes
            for my $cd (-1, 0, 1) {
               next unless $rd || $cd; # get rid of (0, 0)
               my $Ci = $ci + $cd;
               next if $Ci < 0 || $Ci > $row->$#*;
               $retval[$Ri][$Ci] //= 0; # initialize if necessary
               next if $retval[$Ri][$Ci] eq 'x'; # don't overwrite mines
               $retval[$Ri][$Ci]++; # increment close-by position
            }
         }
      }
	}
   return \@retval;
}
