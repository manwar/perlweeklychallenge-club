#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-09-05
# Challenge # 181 Sentence Order ( Julia )

text = "All he could think about was how it would all end.
There was still a bit of uncertainty in the equation, but the basics were there for anyone to see.
No matter how much he tried to see the positive, it wasn't anywhere to be seen.
The end was coming and it wasn't going to be pretty."

result = split(text, ".")

for i in 1:(length(result)-1)

  next = split(result[i])

  str = sort(next, by=lowercase)

  println(join(str,' ') * '.')

end
