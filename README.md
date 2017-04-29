# web.lua
This is a simple single-file web server.

## Configuration
Just edit `config.conf`.
* forbidden (table) = {"forbidden_file_path"}
* default (string) = "index.lua" -- the path of default page

## Features
It only works for current directory.
* Executing lua (it's not secure!)
For `.lua` and `.lsp`, anything between `<?lua ?>` will be execused.
* Resolving parameters for GET -- GET (table).

