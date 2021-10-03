unit module HashJoin;

our sub merge (@table1, $index1, @table2, $index2, :$verbose)
{
  my %table1;
  my @ids;
  my %ids;
  my %result;
  
  for @table1 -> $row1
  {
    my @data1 = @$row1;
    my $id1   = @data1[$index1];
    @ids.push: $id1 unless any(@ids) eq $id1;
    
    say ": Table 1 Row (scan): $id1 -> { @data1.join(", ") }" if $verbose;

    for @table2 -> $row2
    {
      my @data2 = @$row2;
      my $id2   = @data2.splice($index2, 1);
      next unless $id1 eq $id2;
      
      %ids{$id2} = True;
      %result{$id1}.push: (@data1, @data2).flat;
      
      say ": Result Table Row: $id1 -> { @data1.join(", ") } + { @data2.join(", ") }" if $verbose;
    }
  }

  my @result;

  for @ids -> $id
  {
    next unless %ids{$id};
    @result.append: @(%result{$id});
  }

  return @result;
}

our sub hash-join-sorted (@table1, $index1, @table2, $index2, :$verbose)
{
  my %table1;

  for @table1 -> $row
  {
    my @data = @$row;
    my $id   = @data[$index1];

    say ": Table 1 Row (add): $id -> { @data.join(", ") }" if $verbose;
    %table1{$id}.push: @data;
  }

  my %result;

  for @table2 -> $row
  {
    my @data = @$row;
    my $id   = @data.splice($index2, 1);
    
    if $verbose
    {
      say ": Table 1 Row (scan): $id -> { @(%table1{$id}).join(", ") }";
      say ": Table 2 Row (scan): $id -> { @data.join(", ") }";
    }

    for @(%table1{$id}) -> $row
    {
       %result{$id}.push: (@$row, @data).flat;
       say ": Result Table Row: $id -> { @$row.join(", ") } + { @data.join(", ") }" if $verbose;
    }
  }

  for %result.keys.sort -> $id
  {
    my @rows = @(%result{$id});

    for @rows -> $row
    {
      say nicify(@$row); 
    }
  }
}

our sub hash-join (@table1 is copy, $index1 is copy, @table2 is copy, $index2 is copy, :$verbose)
{
  if @table1.elems > @table2.elems
  {
    (@table1, @table2) = (@table2, @table1);
    ($index1, $index2) = ($index2, $index1);
  }

  my %table1;

  for @table1 -> $row
  {
    my @data = @$row;
    my $id   = @data.splice($index1, 1);

    say ": Table 1 Row (add): $id -> { @data.join(", ") }" if $verbose;
    %table1{$id}.push: @data;
  }

  my %result;

  for @table2 -> $row
  {
    my @data = @$row;
    my $id   = @data.splice($index2, 1);
    if $verbose
    {
      say ": Table 1 Row (scan): $id -> { @(%table1{$id}).join(", ") }";
      say ": Table 2 Row (scan): $id -> { @data.join(", ") }";
    }

    for @(%table1{$id}) -> $row
    {
       %result{$id}.push: (@$row, @data).flat;
       say ": Result Table Row: $id -> { @$row.join(", ") } + { @data.join(", ") }" if $verbose;
    }
  }

  for %result.keys.sort -> $id
  {
    my @rows = @(%result{$id});

    for @rows -> $row
    {
      say nicify(|($id, @$row)); 
    }
  }
}

sub nicify (*@data)
{
  return @data.map({ $_ ~~ Numeric ?? $_ !! '"' ~ $_ ~ '"'  }).join(", ");
}

our sub print-it(*@data)
{
  for @data -> $row
  {
    say nicify(@$row);
  }
}
