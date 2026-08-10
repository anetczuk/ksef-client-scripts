# ksef-client-scripts

Access KSeF government invoice system in automated manner. Project wraps `ksef-client` Python package in convenience scripts.


## Features

Some features of the project:
- download invoices
- generate PDF from invoice XML
- generate invoice XML from template
- register sell invoice XML in KSeF

**WARNING:** authors of the project are not resposible for correctness of business information. Neither KSeF nor the project 
validates business information in invoices, epsecially seller and buyer data, tax rates, net and gross values. Once invoice is 
registered in KSeF then it cannot be removed.


## Running the application

Project provides following scripts:
- `ksef-auth` - for authentication
- `ksef-auth-logout` - for logging out
- `ksef-get-credentials` - get access token based on configuration
- `ksef-convert-invoice-pdf` - for converting XMLs to PDFs
- `ksef-download-invoices` - for downloading invoices
- `ksef-generate-invoice` - generate invoice XML from template
- `ksef-send-invoice` - register sell invoice XML in KSeF

Scripts are available after installing the project. It can be installed in virtual environment.

Following example presents possibility of fetching all invoices from previous month:
```bash
source "${VENV_DIR}"/bin/activate
ksef-auth --config "${CONFIG_PATH}"
ksef-download-invoices -st Subject1 -mo 1
ksef-download-invoices -st Subject2 -mo 1
ksef-download-invoices -st Subject3 -mo 1
ksef-download-invoices -st SubjectAuthorized -mo 1
ksef-auth-logout
```

Scripts accept following arguments:

<!-- insertstart include="doc/cmdargs.txt" pre="\n" post="" -->
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
usage: ksef-download-invoices [--subject-type|-st <type>] [--month-offset|-mo <number>] [--out-month-offset|-omo <number>] [--help|-h]

Download invoices from KSeF using active profile. Downloaded files will be placed in 'invoices' subdirectory of current working directory.

options:
  -h, --help                  show this help
  -st, --subject-type         subject type, one of:
                                Subject1 - sell invoices
                                Subject2 - buy invoices
                                Subject3 - third-party invoices
                                SubjectAuthorized - authorized entities
  -mo, --month-offset         month offset:
                                0 or none - current month
                              positive - month from past
  -omo, --out-month-offset    month offset of output directory
  --no-pdf                    do not generate PDF
```

```
usage: ksef-generate-invoice [--invoice|-i <path>] [--output|-o <path>] [--help|-h]

Generate invoice based on given template.

options:
  -h, --help                  show this help
  -i, --invoice               path to invoice XML template file
  -o, --output                path to generated XML file
```

```
usage: ksef-send-invoice [--invoice|-i <path>] [--help|-h]

Send invoices to KSeF using active profile.

options:
  -h, --help                  show this help
  -i, --invoice               path to invoice XML file
```

<!-- insertend -->


## Examples of config files

Example config to authenticate based on token stored in KeePass database file:

<!-- insertstart include="examples/config-keepass.toml" pre="\n```\n" post="```\n" -->
```
#### config

profile.name = "ksef"           # any name
profile.env = "PROD"            # one of: TEST, DEMO, PROD

context.type = "nip"
context.value = "1234567890"

auth.type = "KEEPASSXC"                         # authenticate by accessing keepassxc deamon
auth.dbpath = "/path/example/access.kdbx"       # path to KeePassXC database file
auth.entrytitle = "ksef api token"              # title of keepassxc item (proper user/pass is identified by the title)
```
<!-- insertend -->

Example config to authenticate based on token stored directly in config file:

<!-- insertstart include="examples/config-raw.toml" pre="\n```\n" post="```\n" -->
```
#### config

profile.name = "ksef"           # any name
profile.env = "PROD"            # one of: TEST, DEMO, PROD

context.type = "nip"
context.value = "1234567890"

auth.type = "TOKEN"                                  # authenticate by accessing keepassxc deamon
auth.token = "1122334455-token-example-6677889900"   # raw token
```
<!-- insertend -->

Storing production data directly in config file is not advisable.


## Invoice template example

There is invoice XML example:

<!-- insertstart include="examples/invoice-sell-template-example.xml" pre="\n```\n" post="\n```\n" -->
```
<?xml version="1.0" encoding="UTF-8"?>
<Faktura xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xmlns="http://crd.gov.pl/wzor/2025/06/25/13775/">
  <Naglowek>
    <KodFormularza kodSystemowy="FA (3)" wersjaSchemy="1-0E">FA</KodFormularza>
    <WariantFormularza>3</WariantFormularza>
    <DataWytworzeniaFa>2026-07-09T13:52:07.384Z</DataWytworzeniaFa>
    <SystemInfo>SamploFaktur</SystemInfo>
  </Naglowek>
  <Podmiot1>
    <DaneIdentyfikacyjne>
      <NIP>3941408410</NIP>
      <Nazwa>ABC AGD sp. z o. o.</Nazwa>
    </DaneIdentyfikacyjne>
    <Adres>
      <KodKraju>PL</KodKraju>
      <AdresL1>ul. Przykladowa 1</AdresL1>
      <AdresL2>00-001 Warszawa</AdresL2>
    </Adres>
  </Podmiot1>
  <Podmiot2>
    <DaneIdentyfikacyjne>
      <NIP>5372379895</NIP>
      <Nazwa>F.H.U. Jan Kowalski</Nazwa>
    </DaneIdentyfikacyjne>
    <Adres>
      <KodKraju>PL</KodKraju>
      <AdresL1>ul. Polna 1</AdresL1>
      <AdresL2>00-001 Warszawa</AdresL2>
    </Adres>
    <JST>2</JST>
    <GV>2</GV>
  </Podmiot2>
  <Fa>
    <KodWaluty>PLN</KodWaluty>
    <P_1>2026-08-02</P_1>
    <P_2>${INVOICE_NUMBER}</P_2>
    <P_6>2026-08-01</P_6>
    <P_13_1>${INVOICE_NET_WORTH}</P_13_1>
    <P_14_1>${INVOICE_TAX_AMOUNT}</P_14_1>
    <P_15>${INVOICE_GROSS_AMOUNT}</P_15>
    <Adnotacje>
      <P_16>2</P_16>
      <P_17>2</P_17>
      <P_18>2</P_18>
      <P_18A>2</P_18A>
      <Zwolnienie>
        <P_19N>1</P_19N>
      </Zwolnienie>
      <NoweSrodkiTransportu>
        <P_22N>1</P_22N>
      </NoweSrodkiTransportu>
      <P_23>2</P_23>
      <PMarzy>
        <P_PMarzyN>1</P_PMarzyN>
      </PMarzy>
    </Adnotacje>
    <RodzajFaktury>VAT</RodzajFaktury>
      <FaWiersz>
        <NrWierszaFa>1</NrWierszaFa>
        <P_7>${INVOICE_ITEM_NAME}</P_7>
        <P_8A>szt.</P_8A>
        <P_8B>1</P_8B>
        <P_9A>${INVOICE_NET_WORTH}</P_9A>
        <P_11>${INVOICE_NET_WORTH}</P_11>
        <P_12>${INVOICE_TAX_RATE}</P_12>
      </FaWiersz>
  </Fa>
</Faktura>
```
<!-- insertend -->

It contains following placeholders:
- `${INVOICE_NUMBER}`
- `${INVOICE_NET_WORTH}`
- `${INVOICE_TAX_AMOUNT}`
- `${INVOICE_GROSS_AMOUNT}`
- `${INVOICE_ITEM_NAME}`
- `${INVOICE_TAX_RATE}`

Following script can be used to generate XML and PDF preview from template:
```bash
export INVOICE_NUMBER="FV-$RANDOM"

export INVOICE_ITEM_NAME="service sample"
export INVOICE_NET_WORTH="200"
export INVOICE_TAX_RATE="23"
export INVOICE_TAX_AMOUNT="46"      ## tax amount, have to be calculated properly!
export INVOICE_GROSS_AMOUNT="246"   ## with tax, have to be calculated properly!

ksef-generate-invoice -i "${EXAMPLES_DIR}/invoice-sell-template-example.xml" -o "${OUTPUT_DIR}/invoice-sell.xml"
```

**WARNING:** caller of the script is responsible for providing proper values like tax rate, tax amount and other business information.


## Testing environments

KSeF provides two testing environemnts:
- TEST env: https://ap-test.ksef.mf.gov.pl/ - it is possible to access it with any data (eg. randomly generated NIP),
- DEMO env: https://ap-demo.ksef.mf.gov.pl/ - it has to be accessed with real data (eg. your NIP and password).

**WARNING:** do not enter real, confidential or sensitive business data into TEST or DEMO environments.


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
