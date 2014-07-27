function copy_path
	if type greadlink > /dev/null
		greadlink -f $argv | pbc
	else
		readlink -f $argv | pbc
	end
end
