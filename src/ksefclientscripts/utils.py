#
# Copyright (c) 2023, Arkadiusz Netczuk <dev.arnet@gmail.com>
# All rights reserved.
#
# This source code is licensed under the BSD 3-Clause license found in the
# LICENSE file in the root directory of this source tree.
#

import base64
import hashlib
import json
import logging
import os
import re

from appdirs import user_data_dir

_LOGGER = logging.getLogger(__name__)


def get_app_datadir():
    data_dir = user_data_dir("ksef-client-scripts")
    os.makedirs(data_dir, exist_ok=True)
    return data_dir


def read_data(file_path: str) -> str:
    with open(file_path, encoding="utf-8") as file:
        return file.read()


def write_data(file_path, content):
    with open(file_path, "w", encoding="utf8") as fp:
        fp.write(content)


def calculate_str_hash(content: str):
    data_bytes = content.encode("utf-8")
    # ruff: noqa: S324
    return hashlib.md5(data_bytes).hexdigest()  # nosec


def calculate_dict_hash(data_dict):
    data_str = json.dumps(data_dict, sort_keys=True)
    return calculate_str_hash(data_str)


def prepare_filename(name: str):
    name = name.lower()
    name = re.sub(r"\s+", "_", name)
    # name = name.replace(".", "_")
    name = name.replace("(", "_")
    return name.replace(")", "_")


def encode_base64(content: str):
    data_bytes = content.encode()
    return base64.b64encode(data_bytes)


def decode_base64(b64_content: str):
    data_bytes = base64.b64decode(b64_content)
    return data_bytes.decode()
