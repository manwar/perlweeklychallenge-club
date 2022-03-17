// The Weekly Challenge 153
// Task 2: Factorions
// Usage: $ dart ch-2.dart [Positive Integer]

void main(List<String> arguments) {
// define factorial
  var factorial = [1];
  for (int i = 1; i <= 9; i++) {
    factorial.add(factorial[i-1]*i);
  }

// convert input into a list of non-negative integers < 10
  String mystr = arguments[0];
  var myint = int.parse(mystr);
  mystr = myint.toString();   // avoid leading zeros
  var digits = <int>[];
  mystr.split("").forEach((item) {
    digits.add(int.parse(item));
  });

// sum
  var sum = 0;
  digits.forEach((d) {
    sum += factorial[d];
  });

// wrap-up
  print(   myint.toString() + " is a factorion: " 
         + (sum == myint).toString()               );
}
