# astro-bones

Shared Astro skeleton for personal sites. Cloudflare Pages as the deploy
target. Plain HTML / plain CSS as the aesthetic default — sites paint their
own identity on top.

This is a **GitHub template repository**. Each new site is a separate repo
created from this template.

## Stack

- [Astro 6](https://astro.build) (loose TypeScript — type hints, no strict
  compiler fights)
- Plain CSS, system font stack (no Tailwind, no UI framework)
- Cloudflare Pages for static hosting

## Quick start

If you already have a repo created from this template:

    git clone git@github.com:OWNER/REPO.git
    cd REPO
    nvm use            # or just check Node 22+
    npm install
    npm run dev

Open http://localhost:4321.

If you're spinning up a new site, see [`docs/spin-up-site.md`](docs/spin-up-site.md).

## Project layout

    .
    ├── astro.config.mjs        # static site config
    ├── public/                 # static assets (favicon, images, etc.)
    ├── src/
    │   ├── components/         # reusable .astro components
    │   ├── layouts/            # page wrappers (BaseLayout.astro etc.)
    │   ├── pages/              # routes (filename = URL path)
    │   └── styles/             # CSS (global.css is the base)
    ├── docs/
    │   └── spin-up-site.md     # checklist for creating a new site
    ├── CHANGELOG.md            # what's changed in this template
    └── tsconfig.json

## Adding a page

Drop a `.astro`, `.md`, or `.mdx` file in `src/pages/`. The filename
becomes the route. `src/pages/about.astro` → `/about`.

A typical page:

    ---
    import BaseLayout from '../layouts/BaseLayout.astro';
    ---

    <BaseLayout title="About">
      <main>
        <h1>About</h1>
      </main>
    </BaseLayout>

## Deploy

Sites deploy via Cloudflare Pages, auto-deploying on push to `main`.

Configuration in the Cloudflare dashboard:

- **Build command:** `npm run build`
- **Build output:** `dist`
- **Environment variables:** none for static sites

Preview deploys for PRs are free and on by default.

## Switching to server rendering

When a site grows a need for server-rendered routes (forms, API endpoints,
auth, etc.), switch from Cloudflare Pages static hosting to the current
Cloudflare Workers adapter flow:

    npm install @astrojs/cloudflare

    import { defineConfig } from 'astro/config';
    import cloudflare from '@astrojs/cloudflare';

    export default defineConfig({
      output: 'hybrid',
      adapter: cloudflare(),
    });

**Caveat:** the Cloudflare runtime isn't Node. Some npm packages that work
in `astro dev` will fail in deployed SSR routes (anything depending on
`fs`, `child_process`, or other Node-only APIs). Follow Astro's current
Cloudflare adapter docs when making this switch.

## Conventions

- **Static is the default.** Add server rendering only when a real need shows up.
- **No Tailwind in the skeleton.** A site that wants Tailwind installs it
  per-site. Don't add it here.
- **Pin versions.** Astro moves fast. Update deliberately, not reflexively;
  document changes in `CHANGELOG.md`.
- **Content lives outside the site repo.** This template doesn't ship with
  any markdown collections. The Obsidian → Astro pipeline is a separate
  concern (handled at the content layer, not in this skeleton).

## Updating from the template

Changes to this template don't propagate to existing sites — that's by
design (template repos diverge once cloned). When the skeleton changes:

1. Read `CHANGELOG.md` to see what changed.
2. Decide whether the site you care about needs the change.
3. Port it manually (usually a small diff).

If a change is structural enough that porting is painful, that's the
signal to consider whether the change belongs in the template at all.
