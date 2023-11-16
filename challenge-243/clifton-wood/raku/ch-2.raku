sub floor-sums (*@a) {
  (@a X @a).map({ ( .head / .tail ).floor }).sum.say
}

floor-sums(2, 5, 9);
floor-sums( |(7 xx 7) );
