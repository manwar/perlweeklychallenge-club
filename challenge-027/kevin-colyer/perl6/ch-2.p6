#!/usr/bin/perl6
use v6;

use Test;

# 27.2 Write a script that allows you to capture/display historical data. It could be an object or a scalar. For example
#
# my $x = 10; $x = 20; $x -= 5;
#
# After the above operations, it should list $x historical value in order.

# with ideas from https://stackoverflow.com/questions/31665384/how-does-one-write-custom-accessor-methods-in-perl6
class HistoryInt {
  has Int $.x =0 ;
  has @.history;

  # overwrite the method the attribute declaration added
  method x () is rw {
    Proxy.new(
      FETCH => -> $ { $!x },
      STORE => -> $, Int $new {
        $!x = $new;
        @!history.push: $new;
      }
    )
  }
  method History () {
    @!history;
  }
}

my $h=HistoryInt.new();

$h.x=10;
is $h.History,(10),"list of first op";
$h.x=20;
is $h.History,(10,20),"list of ops";
$h.x-=5;
is $h.History,(10,20,15),"list of ops";

done-testing;

