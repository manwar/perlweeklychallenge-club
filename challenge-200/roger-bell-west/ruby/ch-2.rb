#! /usr/bin/ruby

def sevensegment(l)
  disp = [0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x67]
  v = []
  if l == 0 then
    v = [0]
  else
    ll = l
    while ll > 0 do
      (ll, x) = ll.divmod(10)
      v.push(x)
    end
    v = v.reverse
  end
  d = []
  1.upto(7) do
    d.push(" " * (6 * v.length))
  end
  v.each_with_index do |vv, i|
    x = 6 * i
    da = disp[vv]
        if da & 1 > 0 then
            (x + 1).upto(x + 3) do |xa|
                d[0][xa] = '#'
            end
        end
        if da & 2 > 0 then
            1.upto(2) do |y|
                d[y][x + 4] = '#'
            end
        end
        if da & 4 > 0 then
            4.upto(5) do |y|
                d[y][x + 4] = '#'
            end
        end
        if da & 8 > 0 then
            (x + 1).upto(x + 3) do |xa|
                d[6][xa] = '#'
            end
        end
        if da & 16 > 0 then
            4.upto(5) do |y|
                d[y][x] = '#'
            end
        end
        if da & 32 > 0 then
            1.upto(2) do |y|
                d[y][x] = '#'
            end
        end
        if da & 64 > 0 then
            (x + 1).upto(x + 3) do |xa|
                d[3][xa] = '#'
            end
        end
  end
  d.each do |r|
    print("#{r}\n")
  end
end

sevensegment(1234567890)
sevensegment(200)
