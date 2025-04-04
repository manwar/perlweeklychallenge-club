# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Weekly challenge 315 task 2 - WebAssembly component."""

from __future__ import annotations

from pwc315 import find_third
from wasm_find_third_bindings import exports as wasm_exports


class FindThird(wasm_exports.FindThird):
    def find_third(self, sentence: str, wfirst: str, wsecond: str) -> list[str]:
        return find_third.find_third(sentence, wfirst, wsecond)
