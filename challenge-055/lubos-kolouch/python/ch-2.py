##!/usr/bin/env python
""" https://perlweeklychallenge.org/blog/perl-weekly-challenge-055/
    Challenge 2 - Wave Array """

from itertools import permutations
import sys


class WaveArray:
    """ Does the wave according to the excercise """

    def __init__(self, to_wave: str):
        self.to_wave = to_wave
        self.current_wave = None
        self.all_waves = list()

    def process_all_waves(self):
        """ process all possible permutations"""

        for my_permut in permutations(self.to_wave, len(self.to_wave)):
            self.current_wave = my_permut
            if self.check_wave:
                self.all_waves.append(self.current_wave)

        return self.all_waves

    @property
    def check_wave(self):
        """ Check the wave """

        # 1 = greater, -1 = smaller
        direction = 1
        for seq_count in range(len(self.current_wave)-1):
            if seq_count == len(self.current_wave):
                break
            if direction == 1:
                # stop if wave is broken
                if self.current_wave[seq_count] < self.current_wave[seq_count+1]:
                    return False
            else:
                if self.current_wave[seq_count] > self.current_wave[seq_count+1]:
                    return False

            direction *= -1

        return True


class WaveTest:
    """ run the tests """

    def __init__(self):
        self.test_waveper = None

    def test_all(self):
        """ Do the tests """

        self.test_waveper = WaveArray("1234")
        all_waves = self.test_waveper.process_all_waves()
        assert all_waves == [('2', '1', '4', '3'), ('3', '1', '4', '2'),
                             ('3', '2', '4', '1'), ('4', '1', '3', '2'),
                             ('4', '2', '3', '1')]


def main():
    """ main """
    waver = WaveArray(sys.argv[1])

    all_waves = waver.process_all_waves()
    print(f'{all_waves}')
    wave_tester = WaveTest()
    wave_tester.test_all()


if __name__ == "__main__":
    assert len(sys.argv) == 2
    main()
