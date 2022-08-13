int totient(int n) {
  // totient(1) = 1, also handle totient(0) at the same time as it can be 0 or 1
  if (n <= 1) {
    return 1;
  }
  // calcuation using GCD
  int r = 1; // 1 is relatively prime to any number
  for (int i = 2; i < n; i++) {
    if (gcdEuclidean(i, n) == 1) {
      r++;
    }
  }
  return r;
}

int gcdEuclidean(int a, int b) {
  while (a != b) {
    if (a > b) {
      a -= b;
    } else {
      b -= a;
    }
  }
  return a;
}

bool isPerfect(int n) {
  if (n < 2 || n % 2 == 0) {
    return false;
  }
  var sum = 1;
  var t = totient(n);
  while (t != 1) {
    sum += t;
    if (sum > n) {
      return false;
    }
    t = totient(t);
  }
  return sum == n;
}

void main(List<String> args) {
  int count = args.isNotEmpty ? int.parse(args[0]) : 20;
  var output = "";
  for (int i = 3; i < 50000; i++) {
    if (isPerfect(i)) {
      output += ", ${i.toString()}";
      if (--count == 0) {
        break;
      }
    }
  }
  print(output.substring(2));
}
