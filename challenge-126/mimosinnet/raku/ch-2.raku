# https://perlweeklychallenge.org/blog/perl-weekly-challenge-126/

# Initial array
my $input = q:to/END/;
    x * * * x * x x x x
    * * * * * * * * * x
    * * * * x * x * x *
    * * * x x * * * * *
    x * * * x * * * * x
END

#| 
class Mines {
  has $!rows;
  has $!columns;
  has $.input;
  has @!solution;

  # this submethod builds all the variables. 
  submethod TWEAK {
    $!rows    = self.input.lines.elems;
    $!columns = self.input.lines[0].split(/\s*/,:skip-empty).elems;
    # Mines uses one dimensional array.  
    my @data = self.input.trans( 'x' => '1', '*' => '0' ).split(/\s*/,:skip-empty);
    my @iterable = @data;
    # We need to include the first value of the array: @data[0] = 0. This will be the default
    # value when we move outside the defined values of the array
    @data.unshift: 0;

    # it finds the solution for each coordinate ($i, $j)
    for 1..$!rows -> $i {
      for 1..$!columns -> $j {
        my $value = @iterable.shift;
        # There is a mine in $i, $j if $value = 1;
        if $value == 1 { @!solution.push: 'x' }
        else {
          # We seek for mines around the coordenate ($i, $j)
          my @coords;
          @coords.push: @data[ coords-to-array( ($i - 1), ($j - 1), $!rows, $!columns ) ];
          @coords.push: @data[ coords-to-array( ($i - 1), ($j    ), $!rows, $!columns ) ];
          @coords.push: @data[ coords-to-array( ($i - 1), ($j + 1), $!rows, $!columns ) ];
          @coords.push: @data[ coords-to-array( ($i    ), ($j - 1), $!rows, $!columns ) ];
          @coords.push: @data[ coords-to-array( ($i    ), ($j + 1), $!rows, $!columns ) ];
          @coords.push: @data[ coords-to-array( ($i + 1), ($j - 1), $!rows, $!columns ) ];
          @coords.push: @data[ coords-to-array( ($i + 1), ($j    ), $!rows, $!columns ) ];
          @coords.push: @data[ coords-to-array( ($i + 1), ($j + 1), $!rows, $!columns ) ];
          @!solution.push: @coords.sum;
        }
      }
    }
  }

  #| Function to translate coordenates to position in the unidimensional array
  sub coords-to-array( $i, $j, $rows, $columns) {
    return 0 if ($j < 1        || $i < 1);
    return 0 if ($j > $columns || $i > $rows);
    return $j + ( $i - 1 ) * $columns;
  }

  #| Print the solution
  method print-solution {
    return @!solution.rotor($!columns).join("\n");
  }

}

my $mines = Mines.new( input => $input );
say 'Input:';
say $mines.input;
say "\nOutput: ";
say $mines.print-solution;


