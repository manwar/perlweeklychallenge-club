package main

/*
 AUTHOR: Robert DiCicco
 DATE: 2022-09-16
 Challenge 182 Common Path ( Go )
*/

import (

  "fmt"

  "os"

  "strings"

)

var dirs = []string{"/a/b/c/1/x.pl", "/a/b/c/d/e/2/x.pl", "/a/b/c/d/3/x.pl", "/a/b/c/4/x.pl", "/a/b/c/d/5/x.pl"}

var count = 0

func Intro() {

  fmt.Println("Input:")

  for i := 0; i < len(dirs); i++ {

    fmt.Println("\t", dirs[i])

  }

}

func TestDir(np string) {

  count = 0

  for i := 0; i < len(dirs); i++ {

    if strings.Contains(dirs[i], np) {

      count++

    }

  }

  if count == len(dirs) { // if path is a componet of all array entries

    println("Output:")

    println("\t", np) // print it

    os.Exit(0)        // then exit

  }

}

func NextDir(test string) string {

  s1 := strings.Split(test, "/")

  if len(s1) > 0 {

    s1 = s1[:len(s1)-1]

  }

  return (strings.Join(s1, "/"))

}

func main() {

  Intro()                 // print our list of directories

  val := NextDir(dirs[2]) // pick onr, use it as out starting point

  for 1 == 1 {

    TestDir(val)       // test if each dir entry contain the path

    val = NextDir(val) // drop right hand end off path, and check all again

  }

}
