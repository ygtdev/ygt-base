fx_version "adamant"
game "gta5"

version '1.0.0'

client_script {
    "client/main.lua",
    "client/functions.lua",
    "client/status.lua",
    "config.lua"
}

server_script {
	"@mysql-async/lib/MySQL.lua",
	"server/main.lua"
}