# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Weekly challenge 315 task 1 - WebAssembly component."""

from __future__ import annotations

from pwc315 import find_words
from wasm_find_words_bindings import exports as wasm_exports


class FindWords(wasm_exports.FindWords):
    def find_words(self, wlist: list[str], wchar: str) -> list[int]:
        return find_words.find_words(wlist, wchar)
