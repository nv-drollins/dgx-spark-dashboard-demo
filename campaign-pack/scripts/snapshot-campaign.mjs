#!/usr/bin/env node
import { copyFileSync, existsSync, mkdirSync, readFileSync } from "node:fs";
import { basename, dirname, isAbsolute, join, resolve } from "node:path";

const args = process.argv.slice(2);
const force = args.includes("--force");
const positional = args.filter((arg) => arg !== "--force");
const projectDir = positional[0] ? resolve(positional[0]) : "";
const campaignArg = positional[1] || "";

if (!projectDir || !campaignArg) {
  console.error("Usage: node campaign-pack/scripts/snapshot-campaign.mjs /path/to/project campaign-a-cyan-purple.json [--force]");
  process.exit(1);
}

const campaignPath = isAbsolute(campaignArg) ? campaignArg : resolve(projectDir, campaignArg);
if (!existsSync(campaignPath)) {
  throw new Error(`Campaign JSON not found: ${campaignPath}`);
}

const campaignName = basename(campaignPath);
if (!campaignName.endsWith(".json")) {
  throw new Error(`Expected a .json campaign file, got: ${campaignName}`);
}

JSON.parse(readFileSync(campaignPath, "utf8"));

const snapshotName = campaignName.replace(/\.json$/i, "-before.json");
const snapshotPath = join(dirname(campaignPath), snapshotName);

if (existsSync(snapshotPath) && !force) {
  console.log(`Before snapshot already exists, leaving it unchanged: ${snapshotPath}`);
  console.log("Use --force only if you intentionally want to replace the original before snapshot.");
  process.exit(0);
}

mkdirSync(dirname(snapshotPath), { recursive: true });
copyFileSync(campaignPath, snapshotPath);
JSON.parse(readFileSync(snapshotPath, "utf8"));

console.log(`Before snapshot created: ${snapshotPath}`);
console.log(`Apply critique to this file in place: ${campaignPath}`);
