fun fibstr(aa: String,bb: String,limit: Int): Char {
    var a=aa;
    var b=bb;
    while (true) {
        var c=a+b;
        println(c);
        if (c.length >= limit) {
            return c[limit-1];
        }
        a=b;
        b=c;
    }
}

fun main() {
  if (fibstr("1234","5678",51) == '7') {
    println("Pass")
  } else {
    println("FAIL")
  }
}
