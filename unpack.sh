#!/bin/bash

while getopts "rv" opt; do
    case $opt in
        r)
            recursive=true
            ;;
        v)
            verbose=true
            ;;
        \?)
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

file="$1"

if [ ! -f "$file" ]; then
    echo "Error: Archive file '$file' does not exist."
    exit 1
fi

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

unpack_file() {
    # Unpacking files with .zip extension
    if [ "${1##*.}" == "zip" ]; then
        echo "Name_suffix ${1%.*}-${1##*.}"
        num=$((num + 1))
        if [ "$verbose" = true ]; then
            unzip $1 -d $2
        else
            unzip $1 -d $2
        fi
    
    # Unpacking files with .gz extension
    elif [ "${1##*.}" == "gz" ]; then
        num=$((num + 1))
        if [ "$verbose" = true ]; then
            gunzip -v -c $1 > "$2/${1%.*}"
        else
            gunzip -c $1 > "$2/${1%.*}"
        fi

    # Unpacking files with .bz2 extension
    elif [ "${1##*.}" == "bz2" ]; then
        num=$((num + 1))
        if [ "$verbose" = true ]; then
            bunzip2 -v -c $1 > "$2/${1%.*}"
        else
            bunzip2 -c $1 > "$2/${1%.*}"
        fi
        
    # Unpacking files with .cmpr extension
    elif [ "${1##*.}" == "cmpr" ]; then
        num=$((num + 1))
        if [ "$verbose" = true ]; then
            gunzip -v -c $1 > "$2/${1%.*}"
        else
            gunzip -c $1 > "$2/${1%.*}"
        fi
    else
        echo "Noting to pack"
    fi
}

# Get all files passed
files=()
while [ $# -gt 0 ]; do
    file="$1"

    files+=("$file")

    shift
done

num = 0

decompress() {
    for file in "${files[@]}"; do
        if [ -d "${file%.*}-${file##*.}" ]; then
            echo "${file%.*}-${file##*.} exist aleady"
        else
            mkdir ${file%.*}-${file##*.}
        fi

        echo ""
        echo "This file is been processed: $file"
        unpack_file "$file" ${file%.*}-${file##*.}
    done
    echo "Decompressed $num archive(s)"
}

decompress