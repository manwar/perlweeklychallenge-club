#!/usr/local/bin/jconsole

validate_bitcoin_addr =: _(adverb define)
  NB. characters used to encode base-58
  B58Chars =. '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'

  NB. convert the string of base-58 characters in y to an extended integer
  B58toX =. (x: # B58Chars) #. B58Chars i. ]

  NB. convert an extended integer in y to a list of x base-256 digits
  XtoB256 =. ] #:~ 256 #~ [

  NB. convert a list of base-256 digits in y to a string of corresponding bytes
  B256toByte =. {.@(1&(3!:4))"0

  NB. drop the last four items from y (version and 160 bits)
  vh160 =. _4&}.

  NB. pick the last four items from y (checksum)
  chksum =. _4&{.

  NB. pick the first four items from y
  head =. 4&{.

  NB. calculate the twofold SHA256 digest for y
  DblSha256 =. _3&(128!:6)^:2

  NB. convert base-58 string in y to 25 bytes,
  NB. calculate double SHA256 over the first 21 bytes,
  NB. pick the first four bytes thereof and
  NB. compare it to the last four bytes
  ((chksum -: head @ DblSha256 @ vh160) @: B256toByte @ (25&XtoB256) @ B58toX) f. : [:
)


3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    echo validate_bitcoin_addr 0{:: y
elseif.
    0 = # y
do.
    try.
        assert. validate_bitcoin_addr '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2'
        assert. validate_bitcoin_addr '3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy'
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs STR" to process string'
    echo 'or   "./ch-2.ijs"     to run the examples'
end.
)

exit ''