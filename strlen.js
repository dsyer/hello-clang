import fs from 'fs';
import path from 'path';
const file = fs.readFileSync(path.dirname(import.meta.url).replace("file://", "") + '/strlen.wasm');
let wasm = await WebAssembly.instantiate(file, {});
let { string_length, memory } = wasm.instance.exports;

export { wasm, string_length };