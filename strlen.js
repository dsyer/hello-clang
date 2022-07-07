async function bytes(file) {
	if (typeof fetch !== "undefined") {
		return await fetch(file).then(response => response.arrayBuffer());
	}
    const path = await import('path');
	return await import('fs').then(fs => fs.readFileSync(path.dirname(import.meta.url).replace("file://", "") + "/" + file));
}

let wasm = await WebAssembly.instantiate(await bytes("strlen.wasm"), {});
let { string_length, memory } = wasm.instance.exports;

const encoder = new TextEncoder();

export function strlen(str) {
    new Uint8Array(memory.buffer, 0, str.length + 1).set(encoder.encode(str));
    const result =string_length(0);
    return result;
};