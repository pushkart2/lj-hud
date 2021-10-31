fx_version 'cerulean'
games { 'gta5' }

description 'lj-hud'
version '3.1'
author 'github.com/loljoshie'

client_scripts {
	"config.lua",
	"client/*.lua",
}

server_scripts {
	"config.lua",
	"server/*.lua",
}

ui_page {
	'html/ui.html',	
}

shared_scripts {
	'@qb-core/import.lua',
}

files {
	'html/js/config.js',
	'html/ui.html',
	'html/*.html',
	"html/img/*.svg",
	'html/js/*.js',
	'html/css/*.css',
	'html/css/*.otf',
}
