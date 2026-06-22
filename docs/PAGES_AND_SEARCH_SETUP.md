# Pages and Search Setup

Checked: 2026-06-22

## Site split

There are two separate GitHub Pages sites:

| Site | Repository | Purpose |
| --- | --- | --- |
| Existing user site | `psc5800/psc5800.github.io` | Separate root website; do not overwrite from this blog project |
| Blog project site | `parksc9449-hash/codex-gemma-adsense-blog` | Codex + Gemma AdSense blog kit |

The existing `psc5800.github.io` user site currently has a `CNAME` value of `adelaide.ns.cloudflare.com`. Keep it separate from this blog. Register the blog only after `parksc9449-hash/codex-gemma-adsense-blog` is created and its final public Pages URL or custom domain is confirmed.

## What is already configured

- The local blog repo is configured for `parksc9449-hash/codex-gemma-adsense-blog`.
- `psc5800/psc5800.github.io` has a GitHub Actions Pages workflow so the previous root site can remain separate.
- The blog deployment workflow builds the static site and uploads the `site/` directory.

## Domain options

Choose one before Search Console / Naver registration:

1. Keep the root site custom domain and give this blog its own custom domain.
   Example: `blog.example.com` or `adsense.example.com`.
2. Keep the root site custom domain and publish this blog as a subpath of that domain.
   This requires the root custom domain to point to GitHub Pages correctly.
3. Do not use the existing `psc5800.github.io` root site as this blog's canonical URL.

Do not register `adelaide.ns.cloudflare.com`; it is a Cloudflare nameserver host, not the blog site.

## Search Console flow

After the final public URL is chosen:

1. Open Google Search Console.
2. Add a URL-prefix property for the final blog URL.
3. Choose HTML tag verification.
4. Put the token in `.env` as `GOOGLE_SITE_VERIFICATION`.
5. Run `npm run build`.
6. Push to GitHub and wait for the Pages workflow to complete.
7. Click Verify in Search Console.
8. Submit `sitemap.xml`.

## Naver Search Advisor flow

After the final public URL is chosen:

1. Open Naver Search Advisor / Webmaster Tools.
2. Add the final blog URL.
3. Choose HTML tag verification.
4. Put the token in `.env` as `NAVER_SITE_VERIFICATION`.
5. Run `npm run build`.
6. Push to GitHub and wait for the Pages workflow to complete.
7. Click ownership verification in Naver.
8. Submit `sitemap.xml` and `rss.xml`.
