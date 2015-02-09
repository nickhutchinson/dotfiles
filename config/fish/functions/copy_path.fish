function copy_path
	if type greadlink > /dev/null 2>&1
		greadlink -f $argv | tr -d '\n' | pbc
	else
		readlink -f $argv | tr -d '\n' | pbc
	end
end
