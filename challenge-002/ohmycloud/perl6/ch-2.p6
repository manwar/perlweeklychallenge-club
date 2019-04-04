# convert from base35 to base10
sub decimal-to-base35(Str $n) {
  :35($n.Str)
}

say decimal-to-base35("OOM");

# convert from base10 to base35
sub base35-to-decimal(Int $n) {
    $n.base(35)
}

say base35-to-decimal(30262);