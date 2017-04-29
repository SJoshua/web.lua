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

For example, `<?lua for k, v in pairs(GET) do io.write(k, v) end ?>` is ok.

## Usage
* Printing

Use `io.write` to write something on the page.

* Blocking

Use `io.read` with standard input or anything requires console input will make the program blocked.

The content won't be sent until scripts are executed.
