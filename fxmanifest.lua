fx_version "adamant"
game "gta5"

version '1.0.0'

client_script {
    "client/*.lua"
}

server_script {
	"@mysql-async/lib/MySQL.lua",
	"server/*.lua"
}