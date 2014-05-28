function copy_path
	readlink -f $argv | xsel --clipboard --input
end
