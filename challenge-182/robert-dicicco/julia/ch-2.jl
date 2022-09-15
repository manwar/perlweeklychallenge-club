#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-09-13
# Challenge 182 Common Path ch-2.pl ( Julia )

dirs = [ "/a/b/c/1/x.pl"
         "/a/b/c/d/e/2/x.pl"
         "/a/b/c/d/3/x.pl"
         "/a/b/c/4/x.pl"
         "/a/b/c/d/5/x.pl"
]

function GetDir( test)

  test_dirs = split(test, "/")

  popfirst!(test_dirs)

  pop!(test_dirs)

  return '/' * join(test_dirs, "/")

end

function TestDir(np)

  for d in dirs

    if occursin(np, d)

      global count += 1

    end

  end

  if count == arrsz

    println("Output:")

    println("\t",np)

    exit()

  end

end

function Intro()

  println("Input:")

  for d in dirs

    println("\t",d)

  end

end


  new_path = GetDir( dirs[1])

  count = 0

  arrsz = length(dirs)

  Intro()

  TestDir(new_path)

  secnew = new_path

  while true

    global count = 0

    global new_path = GetDir(secnew)

    TestDir(new_path)

    global secnew = new_path

  end
