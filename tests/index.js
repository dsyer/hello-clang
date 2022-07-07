import assert from "assert";
import { strlen } from "../strlen.js"

async function run() {

    const result = strlen("Hello");
    console.log("Length:", result);
    assert.strictEqual(result, 5);

}

await run();

assert.ok(true);
