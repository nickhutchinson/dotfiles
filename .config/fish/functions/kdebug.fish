function kdebug
	gdb --command=/workspace/Katana/Burgess/Apps/Katana/docs_spi/gdb_katana -p (pidof katanaBin) $argv; 
end
