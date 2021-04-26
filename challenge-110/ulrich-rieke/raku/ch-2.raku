use v6 ;

my @rows = 'infile'.IO.lines ;
my @transposed ; #for the transposed lines
#we assume every line of the input file to have the same number of
#fields
my $len = @rows[0].split( /\,/).elems ;
for (0 .. @rows.elems - 1 ) -> $row {
  my @columns = @rows[$row].split(/\,/) ;
  for (0 .. $len - 1 ) -> $column {
      @transposed[ $column ].push( @columns[ $column] ) ;
  }
}
for @transposed -> $line {
  say $line.join(',') ;
}
