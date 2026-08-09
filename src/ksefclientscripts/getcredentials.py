#!/usr/bin/env python3
#
# Copyright (c) 2026, Arkadiusz Netczuk <dev.arnet@gmail.com>
# All rights reserved.
#
# This source code is licensed under the BSD 3-Clause license found in the
# LICENSE file in the root directory of this source tree.
#

import argparse
import logging
import os
import sys

from pykeepass.exceptions import CredentialsError

from ksefclientscripts.configfile import AuthType, ConfigField, load_config
from ksefclientscripts.keepassxcauth import get_auth_data_direct

SCRIPT_NAME = os.path.basename(sys.argv[0])  # noqa: PTH119


if __name__ == "__main__":
    _LOGGER = logging.getLogger(SCRIPT_NAME)
else:
    _LOGGER = logging.getLogger(__name__)


def get_auth_data(auth_params):
    auth_type = auth_params.get(ConfigField.AUTH_TYPE.value, "RAW")
    if auth_type == AuthType.TOKEN.name:
        _LOGGER.info("authenticate using raw token")
        token = auth_params.get(ConfigField.AUTH_TOKEN.value)
        return ("token", token)

    if auth_type == AuthType.KEEPASSXC.name:
        _LOGGER.info("authenticate using keepassxc")
        db_path = auth_params.get(ConfigField.AUTH_DBPATH.value)
        entry_title = auth_params.get(ConfigField.AUTH_ENTRYTITLE.value)
        auth_data = get_auth_data_direct(db_path, entry_title)
        token = auth_data.get("password")
        return ("token", token)

    _LOGGER.warning("unsupported authentication method: '%s'", auth_type)
    return (None, None)


# ==============================================================================


def main():
    parser = argparse.ArgumentParser(
        prog=SCRIPT_NAME,
        description="get access token",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("-c", "--config", action="store", required=False, help="Path to TOML config file")

    args = parser.parse_args()

    parameters = load_config(args.config)

    auth_dict = parameters.get("auth", {})

    try:
        auth_data = get_auth_data(auth_dict)
    except CredentialsError as exc:
        _LOGGER.error("invalid authentication: %s", exc)
        return 1

    if auth_data[0] == "token":
        print(auth_data[1])  # noqa: T201
        return 0

    _LOGGER.error("unable to get token")
    return 1


if __name__ == "__main__":
    exit_code = main()
    sys.exit(exit_code)
