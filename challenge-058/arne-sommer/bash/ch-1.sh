#! /bin/bash

function comp-ver
{
  echo "$1 cmp $2 -> $3";
  echo -n "Raku /1: "
  ./comp-ver $1 $2
                     
  echo -n "Raku /2: "
  ./comp-ver-int $1 $2
   
  echo -n "Perl:    "
  ./comp-ver.perl $1 $2
  
  echo -n "PHP:     "
  ./comp-ver.php $1 $2

  echo -n "Ruby:    "
  ./comp-ver.ruby $1 $2

  echo -n "Python:  "
  ./comp-ver.py $1 $2
  echo "";
}

comp-ver 0.1   1.1     -1;
comp-ver 2.0   1.2      1;
comp-ver 1.2   1.2_5   -1;
comp-ver 1.2.1 1.2_1    1;
comp-ver 1.2.1 1.2.1    0;
