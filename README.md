# ksef-client-scripts

Access KSeF government invoice system in automated manner. Project heavily based on `ksef-client` Python package.


## Features

Some features of the project:
- download invoices
- generate PDF from invoice XML


## Running the application

Project provides following scripts:
- `ksef-auth` - for authentication
- `ksef-auth-logout` - for logging out
- `ksef-get-credentials` - get access token based on configuration
- `ksef-convert-invoice-pdf` - for converting XMLs to PDFs
- `ksef-download-invoices` - for downloading invoices

Scripts accept following arguments:

<!-- insertstart include="doc/cmdargs.txt" pre="\n" post="\n" -->
```
usage: ksef-auth [-c <path>] [--help|-h]

authenticate to KSeF using config file

options:
  -h, --help      show this help
  -c, --config    path to config toml containing env and auth method
```

```
usage: getcredentials.py [-h] [-c CONFIG]

get access token

options:
  -h, --help            show this help message and exit
  -c CONFIG, --config CONFIG
                        Path to TOML config file (default: None)
```

```
usage: ksef-auth-logout [--help|-h]

logout active profile form KSeF

options:
  -h, --help    show this help
```

```
usage: ksef-convert-invoice-pdf [--invoice|-i <path>] [--help|-h]

Convert KSeF invoice XML to PDF. Generated file will be placed along the XML file.

options:
  -h, --help       show this help
  -i, --invoice    path to invoice XML file or path to directory with XMLs
```

```
usage: ksef-download-invoices [--config|-c <path>] [--subject-type|-st <type>] [--month-offset|-mo <number>] [--out-month-offset|-omo <number>] [--help|-h]

Download invoices from KSeF. Downloaded files will be placed in 'invoices' subdirectory of current working directory.

options:
  -h, --help                  show this help
  -c, --config                path to config toml containing env and auth method
  -st, --subject-type         subject type, one of:
                                Subject1 - sell invoices
                                Subject2 - buy invoices
                                Subject3 - third-party invoices
                                SubjectAuthorized - authorized entities
  -mo, --month-offset         month offset:
                                0 or none - current month
                              positive - month from past
  -omo, --out-month-offset    month offset of output directory
```


<!-- insertend -->


## Installation

Installation of package for use can be done by:
 - to install using *PyPI*: `pip3 install --user ksef-client-scripts`
 - to install package from *GitHub* downloaded ZIP file execute: `pip3 install --user -I file:ksef-client-scripts-master.zip`
 - to install package directly from *GitHub* execute: `pip3 install --user -I git+https://github.com/anetczuk/ksef-client-scripts.git`
 - installation from local repository root directory: `pip3 install --user .`

To uninstall run: `pip3 uninstall ksef-client-scripts`

To install project under virtual environment use `tools/installvenv.sh`.

Development installation is covered in [Development](#development) section.


## Development

Project contains several tools and features that facilitate development and maintenance of the project.

In case of pull requests please run `process-all.sh --release` before the request to check installation, run tests and
perform source code static analysis.


### Installation

Installation for development with configuration of virtual environment:
  - `tools/installvenv.sh --dev` to install dependencies, the package in editable mode and install development tooling.

Installation for development without venv:
  - `tools/install-app.sh --dev` to install dependencies, the package in editable mode and install development tooling.

Virtual environment can be also configured manually by:
  - `python3 -m venv .venv`
  - `source .venv/bin/activate`
  - `python -m pip install --upgrade pip`
  - `tools/install-app.sh --dev` to install dependencies, the package in editable mode and install development tooling
or `python -m pip install -e '.[dev]'` to install project by hand.

There is also possibility to work on the project without installation. In this case project will run from local repository 
directory. This configuration requires installation of dependencies: `./tools/install-deps.sh --dev`.


### Tools scripts

In *tools* directory there can be found following helper scripts:
- `codecheck.sh` -- static code check using several tools with defined set of rules
- `doccheck.sh` -- run `pydocstyle` with defined configuration
- `mdcheck.sh` -- check links in Markdown files
- `typecheck.sh` -- run `mypy` with defined configuration
- `checkall.sh` -- execute *check* scripts all at once
- `profiler.sh` -- profile Python scripts
- `coverage.sh` -- measure code coverate
- `notrailingwhitespaces.sh` -- as name states removes trailing whitespaces from _*.py*_ files
- `rmpyc.sh` -- remove all _*.pyc_ files

Those scripts can be run also from within virtual environment.


## References

- https://ksef.podatki.gov.pl/
- https://github.com/smekcio/ksef-client-python
- https://github.com/Kamilcuk/ksef-pdf-generator
- https://github.com/CIRFMF/ksef-pdf-generator
- https://github.com/CIRFMF/ksef-api


## License

<!-- insertstart include="LICENSE" pre="\n```\n" post="```\n" -->
```
BSD 3-Clause License

Copyright (c) 2026, Arkadiusz Netczuk <dev.arnet@gmail.com>

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
<!-- insertend -->
