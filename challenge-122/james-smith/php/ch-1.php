<?php

class Stream {
  private $stream;
  function __construct() {
    $this->stream = [];
  }
  function add( $var ) {
    if(is_array($var)) {
      foreach( $var as $v ) {
        $this->stream[] = $v;
      }
    } else {
      $this->stream[] = $var;
    }
  }
  function get() {
    if(sizeof($this->stream)>0) {
      return array_shift($this->stream);
    }
    throw new Exception('Empty stream');
  }
}

function stream_average($stream) {
  static $n = 0, $t = 0;
  return ($t+=$stream->get())/++$n;
}

$s = new Stream();

$s->add( array_map( function($x) { return $x*10;}, range(1,50) ) );

while(1) {
  try {
    echo stream_average($s),"\n";
  } catch(Exception $e) {
    break;
  }
}
