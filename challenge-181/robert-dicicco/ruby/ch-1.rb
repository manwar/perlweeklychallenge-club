#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-09-06
# Challenge # 181 Sentence Order ( Ruby )

text = "All he could think about was how it would all end.
There was still a bit of uncertainty in the equation, but the basics were there for anyone to see.
No matter how much he tried to see the positive, it wasn't anywhere to be seen.
The end was coming and it wasn't going to be pretty."

result = text.split('.')

for i in 0..(result.length() - 1) do

  print result[i].split(' ').sort{|x, y | x.downcase <=> y.downcase}.join(' ')

  puts('.')

end
