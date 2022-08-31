use v6.d;

unit sub MAIN(Int $i, *@rest);
@rest.grep(* > $i).say
