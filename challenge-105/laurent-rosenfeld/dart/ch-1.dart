import 'dart:math';

void main() {
  var input = 248832;
  for (int i = 1; i <= 8; i++) {
    var root = pow(input, (1/i));
    print("$i    $root");
  }
}
