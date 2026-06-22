# Pages and Search Setup

Checked: 2026-06-22

## Site split

There are two separate GitHub Pages sites:

| Site | Repository | Purpose |
| --- | --- | --- |
| User site | `psc5800/psc5800.github.io` | Separate root website |
| Blog project site | `psc5800/codex-gemma-adsense-blog` | Codex + Gemma AdSense blog kit |

The user site currently has a `CNAME` value of `adelaide.ns.cloudflare.com`. GitHub redirects project pages under `psc5800.github.io` to that user-site custom domain, so the project blog cannot be registered with Google Search Console or Naver Search Advisor through `https://psc5800.github.io/codex-gemma-adsense-blog/` until the domain strategy is fixed.

## What is already configured

- `psc5800/codex-gemma-adsense-blog` uses GitHub Actions as its Pages source.
- `psc5800/psc5800.github.io` has a GitHub Actions Pages workflow added so the root site can also be deployed as a separate site.
- The blog deployment workflow builds the static site and uploads the `site/` directory.

## Domain options

Choose one before Search Console / Naver registration:

1. Keep the root site custom domain and give this blog its own custom domain.
   Example: `blog.example.com` or `adsense.example.com`.
2. Keep the root site custom domain and publish this blog as a subpath of that domain.
   This requires the root custom domain to point to GitHub Pages correctly.
3. Remove the root site `CNAME` only if `psc5800.github.io` should become the canonical user-site domain.
   This is not the current plan because the root site is separate.

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
