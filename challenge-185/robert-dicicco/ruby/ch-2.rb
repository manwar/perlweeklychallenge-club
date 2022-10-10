#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-10-04
# Challenge 185 Mask Code ( Ruby )

inp = ['ab-cde-123', '123.abc.420', '3abc-0010.xy', '1234567.a', 'a-1234-bc', 'a.b.c.d.e.f']

for code in inp do

  cnt = 0;                    # where we are in the string

  fnd = 0;                    # count of characters changed

  while fnd < 4 do

    if (code[cnt,1] =~ /[0-9]|[a-z]/)

     code[cnt] = 'x'

     fnd += 1

    end

    cnt += 1

  end

  puts code

end
