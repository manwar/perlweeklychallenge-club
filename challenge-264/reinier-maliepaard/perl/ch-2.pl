sub target_array {

  ($aref_1, $aref_2) = @_;
  @source_ = @$aref_1;
  @indices_ = @$aref_2;

  $target_string = "";
  $index = 0;

  foreach $i (@source_) {
      substr($target_string, $indices_[$index], 0) = $i;
      $index++;
  }

  @target_array = split(//, $target_string);
  print("@target_array\n");
}

@source  = (0, 1, 2, 3, 4);
@indices = (0, 1, 2, 2, 1);
target_array (\@source, \@indices); # Output: (0, 4, 1, 3, 2)

@source  = (1, 2, 3, 4, 0);
@indices = (0, 1, 2, 3, 0);
target_array (\@source, \@indices); # Output: (0, 1, 2, 3, 4)

@source  = (1);
@indices = (0);
target_array (\@source, \@indices); # Output: (1)
