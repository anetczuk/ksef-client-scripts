## ksef-auth --help
```
Authenticate to KSeF using config file.

Usage: ksef-auth <config-path> [--help|-h]
  -h, --help      show this help
  -c, --config    path to config toml containing env and auth method
```
## ksef-auth-logout --help
```
Logout active profile form KSeF.

Usage: ksef-auth-logout [--help|-h]
  -h, --help    show this help
```
## ksef-convert-invoice-pdf --help
```
Convert KSeF invoice XML to PDF. Generated file will be placed along the XML file.

Usage: ksef-convert-invoice-pdf [--invoice|-i] [--help|-h]
  -h, --help       show this help
  -i, --invoice    path to invoice XML file or path to directory with XMLs
```
## ksef-download-invoices --help
```
Download invoices from KSeF. Downloaded files will be placed in 'invoices' subdirectory of current working directory.

Usage: ksef-download-invoices [--config|-c] [--subject-type|-st] [--month-offset|-mo] [--help|-h]
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
