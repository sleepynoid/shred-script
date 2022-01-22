#!/bin/bash
ls
echo -n "what file u want to delete: "
read filepath
if [[ $(ls $filepath 2>/dev/null;echo $?) > 0 ]]; then
    echo "No such file or directory"
    exit
fi
search="find "$(pwd)"/$filepath -type f -print0"
#find $PWD/"$filepath" -type f -exec shred -uzvn3 {} \;
$search | xargs -0 shred -uzvn3
#find $(pwd)/"$filepath" -type f -exec crc32 {} +
if [[ $(ls $filepath 2>/dev/null;echo $?) > 0 ]]; then
    echo -n "Delete remaining file? [y/N]"
    read rem_file
    if [[ $rem_file == y ]]; then
    $search | xargs -0 rm -r
    echo "File fully deleted"
    fi
fi
