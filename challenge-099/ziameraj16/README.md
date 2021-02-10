# Pattern Match
## Java Solution

To compile the code run
```java
javac PatternMatcher.java
```
To run
```java
java PatternMatcher
```
### Example
```bash
/perlweeklychallenge-club/challenge-099/ziameraj16$ javac PatternMatcher.java
/perlweeklychallenge-club/challenge-099/ziameraj16$ java PatternMatcher
Enter regex pattern
a.*e
Enter string to match
abcde
Output: 1
/perlweeklychallenge-club/challenge-099/ziameraj16$ java PatternMatcher
Enter regex pattern
a.*d
Enter string to match
abcde
Output: 0
/perlweeklychallenge-club/challenge-099/ziameraj16$ java PatternMatcher
Enter regex pattern
.?b.*d
Enter string to match
abcde
Output: 0
/perlweeklychallenge-club/challenge-099/ziameraj16$ java PatternMatcher
Enter regex pattern
a.*c.?e
Enter string to match
abcde
Output: 1
```
## Kotlin Solution

To compile the code run
```java
kotlinc PatternMatcherKotlin.kt
```
To run
```java
kotlin PatternMatcherKotlin
```
### Example
```bash
/perlweeklychallenge-club/challenge-099/ziameraj16/kotlin$ kotlin PatternMatcherKotlin
Enter regex pattern
a.*e
Enter string to match
abcde
Output: 1
```
