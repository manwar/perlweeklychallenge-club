use v5.36;
use Time::Piece ();

say Time::Piece->strptime($ARGV[0] // die("Usage: $0 DATE\n"), '%Y-%m-%d')->yday + 1;
