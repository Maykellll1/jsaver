fx_version 'cerulean'
game 'gta5'

author 'Miguel Reyes'
description 'Json saver for local storage'
version '1.0.0'

server_scripts {
	'server/library.lua',
	'server/main.lua'
}

lua54 'yes'

server_exports {
	'Create',
	'Load',
	'Save',
	'Get',
	'Set',
	'Exists',
	'Erase'
}