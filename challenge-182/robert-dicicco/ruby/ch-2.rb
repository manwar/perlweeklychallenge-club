#!ruby.exe

# Author: Robert DiCicco
# DATE: 2022-09-14
# Challenge 182 Common Path ( Ruby )

$dirs = [ "/a/b/c/1/x.pl",
        "/a/b/c/d/e/2/x.pl",
        "/a/b/c/d/3/x.pl",
        "/a/b/c/4/x.pl",
        "/a/b/c/d/5/x.pl",
]

$count = 0

def GetDir(test)

  test_dirs = test.split("/")

  test_dirs.shift

  test_dirs.pop

  test_dirs = "/" + test_dirs.join("/")

  return test_dirs

end

def TestDir(np)

  $dirs.each do |d|

    if (d.count np)

      $count += 1

    end

  end

  if $count == $dirs.length()  #5 #dir_cnt

    print("Output:\n")

    print("\t#{np}\n")

    exit()

  end

end

def Intro()

  puts("Input:")

  $dirs.each do |d|

    puts "\t#{d}"

  end

end

def main()

  Intro()

  new_path = GetDir( $dirs[0]);

  secnew = new_path;

  while ( true )

    count = 0

    new_path = GetDir( secnew);

    TestDir(new_path)

    secnew = new_path

  end

end

main()
