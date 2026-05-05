# Spinning up a new site from this template

The "I have a new domain and want a site" checklist. Goal: under 30
minutes from `gh repo create` to a custom domain serving HTTPS.

## 1. Create the repo

    gh repo create OWNER/REPO_NAME \
      --template procrastivity/astro-bones \
      --public \
      --description "Brief description" \
      --clone

Use `--private` if you want to start in private; flip later in repo
settings.

## 2. Install and verify

    cd REPO_NAME
    nvm use            # if using nvm; otherwise check Node 22+
    npm install
    npm run dev

Visit http://localhost:4321. You should see the skeleton placeholder.

## 3. Replace the placeholder

- `src/pages/index.astro` → home page
- New pages → `src/pages/whatever.astro` (filename = route)
- Components → `src/components/`
- Site-specific styles → `src/styles/site.css` (or wherever); import from
  the layout
- Static assets (logos, images, OG cards) → `public/`

Commit and push as you go. Cloudflare Pages preview URLs are free.

## 4. Connect to Cloudflare Pages

In the Cloudflare dashboard:

1. **Workers & Pages → Create → Pages → Connect to Git** → pick the new
   repo.
2. **Build command:** `npm run build`
3. **Build output directory:** `dist`
4. **Environment variables:** none for static sites.

Click deploy. First build takes a couple of minutes.

## 5. Custom domain

In the Pages project settings:

- **Custom Domains → Set up a custom domain → enter the domain.**

If the domain is already on Cloudflare DNS, this is one click — Cloudflare
adds the necessary records automatically and provisions HTTPS.

If the domain is somewhere else, follow Cloudflare's instructions to add
a CNAME. Easier to move the domain to Cloudflare DNS first.

## 6. (Only if needed) Switch to server rendering

Static Cloudflare Pages hosting does not need an adapter. If a site needs
server-rendered routes, switch to the current Astro Cloudflare Workers
adapter flow:

    npm install @astrojs/cloudflare

Then edit `astro.config.mjs`:

    import { defineConfig } from 'astro/config';
    import cloudflare from '@astrojs/cloudflare';

    export default defineConfig({
      output: 'hybrid',                              // change from 'static'
      adapter: cloudflare(),
    });

Follow Astro's Cloudflare adapter docs for the current Workers deployment
details before pushing.

## Common gotchas

- **Adapter caveats.** Cloudflare's runtime isn't Node. Some npm packages
  that work in `astro dev` fail in deployed SSR routes (anything
  depending on `fs`, `child_process`, or other Node-only APIs).
- **Astro version churn.** Astro moves fast. Pin versions; upgrade
  deliberately. Check the upstream `astro-bones` `CHANGELOG.md` before
  bumping.
- **First-time Cloudflare connection** sometimes needs the GitHub app to be
  authorized for the org. The dashboard prompts you through this; takes a
  minute.

## When this checklist is wrong

Update it. This doc lives in the template, so the next site benefits.
