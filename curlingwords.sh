#!/bin/bash

while getopts "w:f:" opt; do
    case $opt in
        w) word="$OPTARG" ;; 
        f) input_file="$OPTARG" ;;  
        *) echo "Usage: $0 -w word -f file"; exit 1 ;;  
    esac
done

if [ -z "$word" ]; then
    echo "Error: You must provide a word to search with the -w parameter."
    echo "Usage: $0 -w word -f file"
    exit 1
fi

if [ -z "$input_file" ]; then
    echo "Error: You must provide a file with the URLs using the -f parameter."
    echo "Usage: $0 -w word -f file"
    exit 1
fi

print_separator() {
    printf '%*s\n' "$(tput cols)" '' | tr ' ' '-'
}

while IFS= read -r url; do
    print_separator
    echo -e "$url\n"

    curl -s "$url" | grep -i --color=always -C1 "$word"

    echo
    print_separator
done < "$input_file"
