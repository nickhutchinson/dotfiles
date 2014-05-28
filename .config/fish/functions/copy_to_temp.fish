function copy_to_temp
   set -l dir (mktemp --directory --tmpdir copy_to_temp.XXXX)
   set -l source (readlink -f "$argv[1]")
   set -l source_basename (basename "$source")
   cp "$source" "$dir"
   echo "$dir/$source_basename"
end
