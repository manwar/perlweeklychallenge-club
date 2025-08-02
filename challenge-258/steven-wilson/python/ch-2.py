#!/usr/bin/env python3


class SetBitSumCalculator:
    def __init__(self):
        self.count_indices = dict()
        self.max_index = 0

    def _count_one_bit_set(self, binary):
        ''' Count the number of 1-bit sets'''
        count = 0
        for b in binary:
            if b == "1":
                count += 1
        return count

    def _populate_count_indices(self, list_length):
        if list_length > self.max_index:
            new_indices = range(self.max_index, list_length)
            binaries = [bin(i) for i in new_indices]
            one_bit = [self._count_one_bit_set(b) for b in binaries]
            for num, count in enumerate(one_bit, start=self.max_index):
                if str(count) in self.count_indices:
                    self.count_indices[str(count)].append(num)
                else:
                    self.count_indices[str(count)] = [num]
            self.max_index = list_length

    def sum_of_values(self, *integers, k=1):
        ''' Given an array of integers and an integer k, find the sum of values
        whose index binary representation has exactly k number of 1-bit set.
        >>> calculator = SetBitSumCalculator()
        >>> calculator.sum_of_values(2, 5, 9, 11, 3, k=1)
        17
        >>> calculator.sum_of_values(2, 5, 9, 11, 3, k=2)
        11
        >>> calculator.sum_of_values(2, 5, 9, 11, 3, k=0)
        2
        '''
        if not isinstance(k, int):
            raise TypeError("k is not a valid input")

        len_integers = len(integers)
        self._populate_count_indices(len_integers)
        return sum(integers[x] for x in self.count_indices[str(k)] if x < len_integers)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
