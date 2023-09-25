unpack_file() {
    return ""
}


check_file_type() {
    local file_extension="${1##*.}"
    
    if [ "$file_extension" == "gz" ] || [ "$file_extension" == "zip" ] || [ "$file_extension" == "bz2" ] || [ "$file_extension" == "cmpr" ] || [ -d "$file_extension" ]; then
        return 0  # Success (true)
    else
        return 1  # Failure (false)
    fi
}


# Get all files passed
files=()
while [ $# -gt 0 ]; do
    file="$1"

    files+=("$file")

    shift
done

decompress() {
    local all_files="$1"
    local -n all_files_ref="$all_files"

    for element in "${all_files[@]}"; do
        echo "$element"
    done

    # for file in "${all_files_ref[@]}"; do
    #     if check_file_type "$file"; then
    #         # decompress ""
    #         echo "In if $file"
    #     else
    #         echo "In else $file"
    #     fi
    # done
}

my_array=("apple" "banana" "cherry")

decompress "$my_array"