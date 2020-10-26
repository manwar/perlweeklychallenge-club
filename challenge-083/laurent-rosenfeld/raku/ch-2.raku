my @a = (defined @*ARGS[0]) ?? @*ARGS !! (5, 5, 8);
my %result;
my @used;
sum-up @a, @used;

sub sum-up (@in is copy, @used-so-far) {
    if @in.elems <= 0 {
        my $sum = [+] @used-so-far;
        %result.push: ($sum => @used-so-far) if $sum >= 0;
    } else {
        my $item = shift @in;
        sum-up(@in, (|@used-so-far, $item));
        sum-up(@in, (|@used-so-far, - $item));
    }
}
my $min-sum = %result.keys.min({+$_});
if %result{$min-sum}[0] ~~ Int {
  say "Sum: $min-sum - digits: %result{$min-sum}";
  say "Number of negative numbers: ",
    %result{$min-sum}.grep(* < 0).elems;
} else {
  my $min-neg = Inf;
  my $min_neg_index;
  for 0..%result{$min-sum}.end -> $i {
    my $negative_numbers = %result{$min-sum}[$i].grep(* < 0).elems;
    if $negative_numbers < $min-neg {
      $min-neg = $negative_numbers;
      $min_neg_index = $i;
    }
  }

  say "Sum: $min-sum - digits  %result{$min-sum}[$min_neg_index]";
  say "Number of negative numbers: $min-neg";
}
