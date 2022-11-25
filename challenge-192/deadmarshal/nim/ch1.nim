import std/[bitops,math]

proc binaryFlip(n:int):int =
  bitand(bitnot(n), (2 ^ int(ln(float(n))/ln(float(2)))-1))
  
echo binaryFlip(5)
echo binaryFlip(4)
echo binaryFlip(6)
