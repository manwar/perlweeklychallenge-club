#!/usr/bin/env python3

import unittest

def reconstruct_melody(composer, notes, perm):
    reordered = [None] * len(notes)
    indices   = map(lambda x: x - 1, perm)

    def assign(idx_note):
        reordered[idx_note[0]] = idx_note[1]

    list(map(assign, zip(indices, notes)))
    return f"{composer.upper()} => {' '.join(reordered)}"

class TestReconstructMelody(unittest.TestCase):
    def test_examples(self):
        examples = [
            {
                "in": ['Bach', ['C','D','E','F#','G','A','B'], [7,1,6,2,5,3,4]],
                "out": "BACH => D F# A B G E C",
            },
            {
                "in": ['Beethoven', ['C','D','F#','G','Ab'], [1,3,5,2,4]],
                "out": "BEETHOVEN => C G D Ab F#",
            },
            {
                "in": ['Brahms', ['C','Db','Eb','F','G','Ab','Bb','C','D'], [9,3,7,1,8,5,2,6,4]],
                "out": "BRAHMS => F Bb Db D Ab C Eb G C",
            },
            {
                "in": ['Bruckner', ['G','F#','Bb','C','D','Eb','F'], [4,7,2,6,1,5,3]],
                "out": "BRUCKNER => D Bb F G Eb C F#",
            },
            {
                "in": ['Berg', ['C#'], [1]],
                "out": "BERG => C#",
            },
        ]

        for ex in examples:
            self.assertEqual(reconstruct_melody(*ex["in"]), ex["out"])

if __name__ == '__main__':
    unittest.main()
