sub greater-character(@arr, $target)
{
  @arr = @arr.sort({.Str});
  for 0..^@arr.elems -> $i
  {
    return @arr[$i] if @arr[$i] gt $target;
  }
  return $target;
}

say greater-character([qw/e m u g/], 'b');
say greater-character([qw/d c e f/], 'a');
say greater-character([qw/j a r/], 'o');
say greater-character([qw/d c a f/], 'a');
say greater-character([qw/t g a l/], 'v');

