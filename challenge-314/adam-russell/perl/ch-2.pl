
  
use v5.40; 

  
sub sort_columns{
    my $s = [@_];
    my $i = 0;
    my $removals = 0;
    do{
        my $i = $_;
        
  my $column = [map {my @w = split //, $_; $w[$i]} @{$s}];

        
  my @sorted = sort {$a cmp $b} @{$column};
  my @check = grep {$sorted[$_] eq $column->[$_]} 0 .. @{$column} - 1;
  my $sorted = 0 + @check == 0 + @sorted;

        $removals++ unless $sorted;
    } for 0 .. length($s->[0]) - 1;
    return $removals;
}

  
MAIN:{
  say sort_columns qw/swpc tyad azbe/;
  say sort_columns qw/cba daf ghi/;
  say sort_columns qw/a b c/;
}

