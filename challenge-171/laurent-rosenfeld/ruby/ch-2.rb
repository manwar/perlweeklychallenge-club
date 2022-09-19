def compose(h1, h2)
    lambda {|x| h1.call(h2.call(x))}
end
f = lambda { |x| return x / 2 + 1 }
g = lambda { |x| return x * 2 }

h = compose(f, g)
for i in 1.upto(6)
    print ("#{h[i]}  #{f.call(g.call(i))}\n")
end
