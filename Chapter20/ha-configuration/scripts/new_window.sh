function new_window {
    TMP_FILE=$(mktemp "/tmp/command.XXXXXX")
    echo "#!/usr/bin/env bash" > $TMP_FILE

    # Copy over environment (including functions), but filter out readonly stuff
    set | grep -v "\(BASH_VERSINFO\|EUID\|PPID\|SHELLOPTS\|UID\)" >> $TMP_FILE

    # Copy over exported envrionment
    export -p >> $TMP_FILE

    # Change to directory
    echo "cd $(pwd)" >> $TMP_FILE

    # Copy over target command line
    echo "$@" >> $TMP_FILE

    chmod +x "$TMP_FILE"
    open -b com.apple.terminal "$TMP_FILE"

    sleep .1 # Wait for terminal to start
#    rm "$TMP_FILE"
}
