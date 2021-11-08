# The Weekly Challenge 118
# Task 1 Binary Palindrome
# Usage: echo "N" | awk -f 'ch-1.awk'
# or: awk -f 'ch-1.awk' < file_contains_an_integer_on_each_line

{
    n = $0
    i = 0
    while (n > 0) {
        arr[i] = n % 2
        n = int(n / 2)
        i++
    }
    len = i-1
    i = 0
    while (arr[len-i] == arr[i] && i < len/2) {
        i++
    }
    print arr[len-i]==arr[i] ? 1 : 0
}
