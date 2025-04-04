from typing import TypeVar, Generic, Union, Optional, Protocol, Tuple, List, Any, Self
from types import TracebackType
from enum import Flag, Enum, auto
from dataclasses import dataclass
from abc import abstractmethod
import weakref

from ..types import Result, Ok, Err, Some


class FindThird(Protocol):

    @abstractmethod
    def find_third(self, sentence: str, wfirst: str, wsecond: str) -> List[str]:
        raise NotImplementedError


