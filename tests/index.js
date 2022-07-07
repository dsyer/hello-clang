import assert from "assert";
import { wasm, string_length } from "../strlen.js"

const encoder = new TextEncoder();
const decoder = new TextDecoder();

async function run() {

    const { memory } = wasm.instance.exports;

    const name = "World";
    new Uint8Array(memory.buffer, 0, name.length + 1).set(encoder.encode(name));
    const result =string_length(0);
    console.log("Length:", result);
    assert.strictEqual(result, 5);

}

await run();

assert.ok(true);
