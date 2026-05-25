import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

// Posts are synced from the content repo (simensen/beausimensen-com-content)
// into ./content/posts at build time by scripts/fetch-content.sh.
const posts = defineCollection({
  loader: glob({
    pattern: '**/*.md',
    base: './content/posts',
  }),
  schema: z.object({
    title: z.string(),
    date: z.coerce.date(),
    description: z.string().optional(),
    tags: z.array(z.string()).optional(),
  }),
});

// Standalone pages (e.g. /now) live alongside posts in the content repo,
// under ./content/pages. They route at the root by `slug` (falling back to
// the file-derived id).
const pages = defineCollection({
  loader: glob({
    pattern: '**/*.md',
    base: './content/pages',
  }),
  schema: z.object({
    title: z.string(),
    description: z.string().optional(),
    updated: z.coerce.date().optional(),
    slug: z.string().optional(),
  }),
});

export const collections = { posts, pages };
