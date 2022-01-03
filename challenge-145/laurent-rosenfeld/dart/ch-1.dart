var a1 = [1, 2, 3];
var a2 = [4, 5, 6];

void main() {
    int result = 0;
    for (int i = 0; i < 3; i++ ) {
        result += a1[i] * a2[i];
    }
    print(result);
}
