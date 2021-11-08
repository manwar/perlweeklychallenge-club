<?php

$TESTS = [ [101,86],[18,33] ];

foreach($TESTS as $_ ) {
  echo swap_nibble($_[0]) == $_[1] ? 'OK' : '--',"\n";
  echo swap_nibble($_[1]) == $_[0] ? 'OK' : '--',"\n";
}

function swap_nibble($_) {
  return ($_>>4) | (($_&15)<<4);
}

