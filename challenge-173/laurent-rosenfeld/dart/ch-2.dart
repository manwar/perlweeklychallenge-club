void main() { var s = BigInt.from(2); print(s); var one = BigInt.from(1); for (int i = 1; i <= 9; i++) { s = s * (s - one) + one; print(s); } }
