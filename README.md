This project shows one way to compile a simple program in C to WASM. The sample exports a single function which in turn depends on `strlen` from the standard libraries. There are no syscalls in `strlen` so we don't really need WASI, but we do need a WASM libc, and the easiest way to get that is to use the [wasi-sdk](https://github.com/WebAssembly/wasi-sdk). Wasi-sdk provides a compiler (`clang`), a linker (`wasm-ld`), and some libraries like `libc`.

Everything should work with [Nix](https://nixos.org) or in [devcontainer in VSCode](https://code.visualstudio.com/docs/remote/containers) (and by extension Codespaces). If you want to grab dependencies manually look at the `Dockerfile` or the `shell.nix`.

Build:

```
$ make
```

Inspect:

```
$ wasm-dis strlen.wasm
```

Run:

```
$ npm test
```

or

```
$ python3 -m http.server 8000
```

and visit on localhost:8000.