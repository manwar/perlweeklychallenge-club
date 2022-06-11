#! /usr/bin/ruby

f = {}
r = {}

while line = gets
  line = line.chomp
  b = 1
  v = 0
  "a".upto("z") do |l|
    if !line.index(l).nil? then
      v |= b
    end
    b <<= 1
  end
  if !r.has_key?(v) || r[v].length > line.length then
    f[line]=v
    r[v]=line
  end
end

w = []
lt = (1 << 26) - 1
lu = [0]
while (lu[-1] != lt) do
  wn = ""
  if (w.length > 0) then
    mode = 0
    sc = []
    r.each_key do |wv|
      if (wv & lu[-1]) == 0 then
        if mode == 0 then
          mode = 1
          sc = []
        end
        sc.push(r[wv])
      elsif mode == 0 && (wv | lu[-1]) != lu[-1] then
        sc.push(r[wv])
      end
    end
    if sc.length == 0 then
      w.pop
      lu.pop
    else
      wn = sc[rand(sc.length)]
    end
  else
    sc = f.keys
    wn = sc[rand(sc.length)]
  end
  if wn != "" then
    w.push(wn)
    lu.push(lu[-1] | f[wn])
  end
end

print(w.join(" ") + "\n")
