## ksef-auth --help
```
usage: ksef-auth [-c <path>] [--help|-h]

authenticate to KSeF using config file

options:
  -h, --help      show this help
  -c, --config    path to config toml containing env and auth method
```

## ksef-get-credentials --help
```
usage: getcredentials.py [-h] [-c CONFIG]

get access token

options:
  -h, --help            show this help message and exit
  -c CONFIG, --config CONFIG
                        Path to TOML config file (default: None)
```

## ksef-auth-logout --help
```
usage: ksef-auth-logout [--help|-h]

logout active profile form KSeF

options:
  -h, --help    show this help
```

## ksef-convert-invoice-pdf --help
```
usage: ksef-convert-invoice-pdf [--invoice|-i <path>] [--help|-h]

Convert KSeF invoice XML to PDF. Generated file will be placed along the XML file.

options:
  -h, --help       show this help
  -i, --invoice    path to invoice XML file or path to directory with XMLs
```

## ksef-download-invoices --help
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

