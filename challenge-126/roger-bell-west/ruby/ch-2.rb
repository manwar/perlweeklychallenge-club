#! /usr/bin/ruby

ina=[
  ['x','*','*','*','x','*','x','x','x','x'],
  ['*','*','*','*','*','*','*','*','*','x'],
  ['*','*','*','*','x','*','x','*','x','*'],
  ['*','*','*','x','x','*','*','*','*','*'],
  ['x','*','*','*','x','*','*','*','*','x']
]

ymax=ina.length()-1
xmax=ina[0].length()-1

mn=Array.new(ymax+1) {Array.new(xmax+1,0)}

0.upto(ymax) do |y|
  sy=[0,y-1].max.upto([ymax,y+1].min)
  0.upto(xmax) do |x|
    sx=[0,x-1].max.upto([xmax,x+1].min)
    if ina[y][x] == 'x' then
      sy.each do |yi|
        sx.each do |xi|
          if xi==x && yi==y then
            next
          end
          mn[yi][xi] += 1
        end
      end
    end
  end
end

0.upto(ymax) do |y|
  0.upto(xmax) do |x|
    if ina[y][x] == "x" then
      mn[y][x]="x"
    end
  end
  print(mn[y].join(" ")+"\n")
end
