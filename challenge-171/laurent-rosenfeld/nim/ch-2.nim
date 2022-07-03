import sugar

proc compose[A,B,C](h1: A -> B, h2: B -> C): A -> C = (x: A) => h1(h2(x))

proc f(x: int): int = int(x / 2) + 1
proc g(x: int): int = x * 2

var h = compose(f, g)
for i in 1..6:
  echo (h(i), f(g(i)))
