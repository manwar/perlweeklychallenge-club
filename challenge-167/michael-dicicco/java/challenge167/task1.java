/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package challenge167;

/**
 *
 * @author mddicicco
 */
public class task1 {

    /**
     * Challenge 167 Task1
     *
     * Solution By: Michael DiCicco
     *
     * Write a script to find out first 10 circular primes having at least 3
     * digits (base 10). Please checkout wikipedia for more information. A
     * circular prime is a prime number with the property that the number
     * generated at each intermediate step when cyclically permuting its (base
     * 10) digits will also be prime.
     *
     * Output 113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933
     */
    
    public static void main(String[] args) {
        String[] ten_circular_primes = new String[10];
        String someNumber = "111";
        int index = 0;
        while (ten_circular_primes[9] == null) {
            if (circularprime.validate(someNumber)) {
                if (!circularprime.used_numbers.contains(someNumber)) {
                    ten_circular_primes[index] = someNumber;
                    index++;
                }
            }
            someNumber = Integer.toString(Integer.parseInt(someNumber) + 1);
        }
        System.out.println(String.join(", ", ten_circular_primes));

    }
}
