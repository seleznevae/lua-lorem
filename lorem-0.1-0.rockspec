package = "lorem"
version = "0.1-0"
source = {
   url = "https://github.com/ayuseleznev/lua-lorem"
}
description = {
   summary = "Library to generate a placeholder text (lorem ipsum).",
   homepage = "https://github.com/ayuseleznev/lua-lorem",
   license = "MIT/X11"
}
dependencies = {}
build = {
    type = "builtin",
    modules = {lorem = 'src/lorem.lua'}
}
