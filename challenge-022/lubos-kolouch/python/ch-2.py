#!/usr/bin/env python
# -*- coding: utf-8 -*-


class LZW:

    def encode(self, data: str) -> list[int]:
        """Encode the input data using the LZW compression algorithm.

        :param data: A string representing the data to be compressed
        :return: A list of integers representing the compressed data
        """
        dictionary = {chr(i): i for i in range(256)}

        current_string = ""
        encoded_data = []

        for char in data:
            combined_string = current_string + char
            if combined_string in dictionary:
                current_string = combined_string
            else:
                encoded_data.append(dictionary[current_string])
                dictionary[combined_string] = len(dictionary)
                current_string = char

        if current_string:
            encoded_data.append(dictionary[current_string])

        return encoded_data

    def decode(self, encoded_data: list[int]) -> str:
        """Decode the input data using the LZW compression algorithm.

        :param encoded_data: A list of integers representing the compressed data
        :return: A string representing the decompressed data
        """
        dictionary = {i: chr(i) for i in range(256)}

        current_string = chr(encoded_data[0])
        decoded_data = [current_string]

        for code in encoded_data[1:]:
            if code in dictionary:
                entry = dictionary[code]
            elif code == len(dictionary):
                entry = current_string + current_string[0]
            else:
                raise ValueError(f"Invalid code: {code}")

            decoded_data.append(entry)

            dictionary[len(dictionary)] = current_string + entry[0]
            current_string = entry

        return "".join(decoded_data)


if __name__ == "__main__":
    input_data = "ABABABABABABABAB"

    lzw = LZW()
    compressed_data = lzw.encode(input_data)
    print(f"Compressed data: {compressed_data}")

    decompressed_data = lzw.decode(compressed_data)
    print(f"Decompressed data: {decompressed_data}")
