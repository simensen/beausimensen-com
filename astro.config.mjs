// @ts-check
import { defineConfig } from 'astro/config';

// Static output deploys cleanly to Cloudflare Pages without an adapter.
// If a site needs server-rendered routes, install @astrojs/cloudflare and
// follow the current Astro Cloudflare Workers adapter guide.

export default defineConfig({
  output: 'static',
});
