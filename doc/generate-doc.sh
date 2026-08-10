#!/bin/bash

set -eu


## works both under bash and sh
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")


SRC_DIR="$SCRIPT_DIR/../src"
SRC_DIR=$(realpath "${SRC_DIR}")


HELP_MD_PATH="$SCRIPT_DIR/cmdargs.md"
HELP_TXT_PATH="$SCRIPT_DIR/cmdargs.txt"
    

## clear file
truncate -s 0 "${HELP_MD_PATH}"
truncate -s 0 "${HELP_TXT_PATH}"


cd "${SRC_DIR}"


## $1 - command
## $2 - command text (optional)
generate_tools_help() {
    local COMMAND="${1}"
    local COMMAND_TEXT="${COMMAND}"
    if [[ $# -gt 1 ]]; then
        COMMAND_TEXT="${2}"
    fi

    echo "## $COMMAND_TEXT --help" >> "${HELP_MD_PATH}"
    echo -e "\`\`\`" >> "${HELP_MD_PATH}"
    $COMMAND --help >> "${HELP_MD_PATH}"
    echo -e "\`\`\`" >> "${HELP_MD_PATH}"

    echo -e "\`\`\`" >> "${HELP_TXT_PATH}"
    $COMMAND --help >> "${HELP_TXT_PATH}"
    echo -e "\`\`\`" >> "${HELP_TXT_PATH}"


    FAILED=0
    tools=$($COMMAND --listtools 2> /dev/null) || FAILED=1

    if [ $FAILED -eq 0 ]; then
        IFS=', ' read -r -a tools_list <<< "$tools"
    
        for item in "${tools_list[@]}"; do
            echo "checking tool: $item"

            echo -e "\n\n" >> "${HELP_MD_PATH}"
            echo "## <a name=\"${item}_help\"></a> $COMMAND_TEXT $item --help" >> "${HELP_MD_PATH}"
            echo -e "\`\`\`" >> "${HELP_MD_PATH}"
            $COMMAND "$item" --help >> "${HELP_MD_PATH}"
            echo -e "\`\`\`"  >> "${HELP_MD_PATH}"
    
            echo -e "\n\n" >> "${HELP_TXT_PATH}"
            echo -e "\`\`\`" >> "${HELP_TXT_PATH}"
            $COMMAND "$item" --help >> "${HELP_TXT_PATH}"
            echo -e "\`\`\`" >> "${HELP_TXT_PATH}"
        done
    else
        echo "$COMMAND: no --listtools found"
    fi


    echo >> "${HELP_MD_PATH}"
    echo >> "${HELP_TXT_PATH}"
}


generate_tools_help "${SRC_DIR}/ksef-auth" "ksef-auth"
generate_tools_help "${SRC_DIR}/ksefclientscripts/getcredentials.py" "ksef-get-credentials"
generate_tools_help "${SRC_DIR}/ksef-auth-logout" "ksef-auth-logout"
generate_tools_help "${SRC_DIR}/ksef-convert-invoice-pdf" "ksef-convert-invoice-pdf"
generate_tools_help "${SRC_DIR}/ksef-download-invoices" "ksef-download-invoices"

generate_tools_help "${SRC_DIR}/ksef-generate-invoice" "ksef-generate-invoice"
generate_tools_help "${SRC_DIR}/ksef-send-invoice" "ksef-send-invoice"
