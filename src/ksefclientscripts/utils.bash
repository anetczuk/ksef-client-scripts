#
#
#


## $1 - invoices json content
## $2 - output dir
convert_invoice_json_to_pdf() {
    local invoice_list_json="${1}"
    local INVOICES_DIR="${2}"

    mkdir -p "${INVOICES_DIR}"
    
    while read -r obj; do
        echo "converting XML to PDF"
        invoice_ksef_number=$(jq -r '.ksefNumber' <<< "${obj}")
        invoice_xml_path="${INVOICES_DIR}/${invoice_ksef_number}.xml"
        "${SCRIPT_DIR}"/ksef-convert-invoice-pdf "${invoice_xml_path}"
    
    done < <(jq -c '.data.items[]' <<< "${invoice_list_json}")
}


## $1 - invoices json content
## $2 - output dir
convert_export_json_to_pdf() {
    local invoice_list_json="${1}"
    local INVOICES_DIR="${2}"

    mkdir -p "${INVOICES_DIR}"
    
    while read -r obj; do
        echo "converting XML to PDF"   
        invoice_ksef_number=$(jq -r '.ksefNumber' <<< "${obj}")
        invoice_xml_path="${INVOICES_DIR}/${invoice_ksef_number}.xml"
        ksef-convert-invoice-pdf --invoice "${invoice_xml_path}"
    done < <(jq -c '.invoices[]' <<< "${invoice_list_json}")
}


## $! -- response json content
is_json_ok() {
    local json_content="${1}"

    if ! jq -e '.ok == true' <<< "${json_content}" > /dev/null; then
        ## also happens if passed invalid json content
        echo "invalid json or status not OK"
#         exit 1
        return 1
    fi
    return 0
#     exit 0
}
