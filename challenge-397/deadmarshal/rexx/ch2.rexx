say binary_reflection('3 6 12')
say binary_reflection('1 2 4 8')
say binary_reflection('7 8 9 10')
say binary_reflection('5 9 15 17')
say binary_reflection('11 13 14 19')

exit

/* reverse the binary digits of u and read them back as a number */
reflect: procedure
  parse arg u
  r = 0
  do while u > 0
    r = r * 2 + u // 2
    u = u % 2
  end
  return r

binary_reflection: procedure
  parse arg arr
  n = words(arr)
  do i = 1 to n
    v.i = word(arr,i) + 0
    k.i = reflect(v.i)
  end

  /* insertion sort on (reflection, value) */
  do i = 2 to n
    cv = v.i
    ck = k.i
    j = i - 1
    do while j >= 1
      if k.j > ck | (k.j = ck & v.j > cv) then do
        jj = j + 1
        v.jj = v.j
        k.jj = k.j
        j = j - 1
      end
      else leave
    end
    jj = j + 1
    v.jj = cv
    k.jj = ck
  end

  out = ''
  do i = 1 to n
    out = out v.i
  end
  return strip(out)
