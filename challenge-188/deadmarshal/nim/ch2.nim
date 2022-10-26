proc TotalZero(xin,yin:int):int =
  var
    x = xin
    y = yin
  while x > 0 and y > 0:
    if x >= y: x -= y else: y -= x
    inc(result)
    
echo TotalZero(5,4)
echo TotalZero(4,6)
echo TotalZero(2,5)
echo TotalZero(3,1)
echo TotalZero(7,4)

