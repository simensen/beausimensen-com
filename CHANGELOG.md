# Changelog

All notable changes to this template are recorded here so future-you knows
what's changed since the last clone.

When you change the skeleton, add an entry. Date + a few bullets is enough.

---

## 0.1.0 — 2026-05-02

Initial scaffold.

- Astro 6 with loose TypeScript (extends `astro/tsconfigs/base`, not strict)
- `output: 'static'` default; no adapter required for Cloudflare Pages static
  hosting
- Plain CSS baseline (`src/styles/global.css`) with a system font stack;
  no Tailwind
- Standard folder structure: `src/pages`, `src/components`, `src/layouts`,
  `src/styles`, `public/`
- `BaseLayout.astro` with `title` + optional `description` props
- Placeholder favicon (neutral dark square — replace per-site)
- `docs/spin-up-site.md` — checklist for creating a new site from this
  template, including the Cloudflare Pages connection steps
- Pinned to Node 22 via `.nvmrc`
