fx_version 'adamant'
game 'gta5'
author 'BlackBhul#0101'
description 'Kit da meccanici!'

shared_script '@es_extended/imports.lua'

client_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    'client.lua',
}

server_scripts {
    'config.lua',
    'server.lua',
}

dependencies {
    'es_extended'
}