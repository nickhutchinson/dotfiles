function copy_path
	if type greadlink > /dev/null 2>&1
		greadlink -f $argv | pbc
	else
		readlink -f $argv | pbc
	end
end
