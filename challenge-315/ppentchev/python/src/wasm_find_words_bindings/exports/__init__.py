from typing import TypeVar, Generic, Union, Optional, Protocol, Tuple, List, Any, Self
from types import TracebackType
from enum import Flag, Enum, auto
from dataclasses import dataclass
from abc import abstractmethod
import weakref

from ..types import Result, Ok, Err, Some


class FindWords(Protocol):

    @abstractmethod
    def find_words(self, wlist: List[str], wchar: str) -> List[int]:
        raise NotImplementedError


