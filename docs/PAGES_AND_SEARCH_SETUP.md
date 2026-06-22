# Pages and Search Setup

Checked: 2026-06-22

## Site split

There are two separate GitHub Pages sites:

| Site | Repository | Purpose |
| --- | --- | --- |
| Existing user site | `psc5800/psc5800.github.io` | Separate root website; do not overwrite from this blog project |
| Naver verification root | `parksc9449-hash/parksc9449-hash.github.io` | Root domain verification for Naver |
| Blog project site | `parksc9449-hash/codex-gemma-adsense-blog` | Codex + Gemma AdSense blog kit |

The existing `psc5800.github.io` user site currently has a `CNAME` value of `adelaide.ns.cloudflare.com`. Keep it separate from this blog.

Final blog URL:

```text
https://parksc9449-hash.github.io/codex-gemma-adsense-blog/
```

Naver root URL:

```text
https://parksc9449-hash.github.io/
```

## What is already configured

- The local blog repo is configured for `parksc9449-hash/codex-gemma-adsense-blog`.
- GitHub Pages source is set to GitHub Actions.
- HTTPS enforcement is enabled.
- `parksc9449-hash/parksc9449-hash.github.io` is configured with Naver HTML file verification and a root page linking to the blog.
- `psc5800/psc5800.github.io` has a GitHub Actions Pages workflow so the previous root site can remain separate.
- The blog deployment workflow builds the static site and uploads the `site/` directory.

## Domain options

The default project URL above is ready for Search Console / Naver registration. A custom domain can still be added later:

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
4. Copy only the token value from the meta tag.
5. Run:

```powershell
.\scripts\set-search-verification.ps1 -GoogleToken "google-token"
git add .github/workflows/pages.yml scripts docs README.md
git commit -m "Configure search verification support"
git push
```

6. Wait for the Pages workflow to complete.
7. Click Verify in Search Console.
8. Submit:

```text
https://parksc9449-hash.github.io/codex-gemma-adsense-blog/sitemap.xml
```

Current Google HTML file verification is deployed from:

```text
public/site-root/google6ed3a0194166dacb.html
```

## Naver Search Advisor flow

Naver registration is done against the root URL:

```text
https://parksc9449-hash.github.io
```

Current verification assets:

```text
https://parksc9449-hash.github.io/naverd5f33a16cf083a48aadfdb00e2ea913f.html
<meta name="naver-site-verification" content="3cc68671910b00467cbe39591dced2a867329643">
```

After ownership is verified, submit the blog sitemap and RSS:

```text
https://parksc9449-hash.github.io/codex-gemma-adsense-blog/sitemap.xml
https://parksc9449-hash.github.io/codex-gemma-adsense-blog/rss.xml
```

Legacy manual flow:

1. Open Naver Search Advisor / Webmaster Tools.
2. Add `https://parksc9449-hash.github.io`.
3. Choose HTML tag verification.
4. Copy only the token value from the meta tag.
5. Run:

```powershell
.\scripts\set-search-verification.ps1 -NaverToken "naver-token"
git push
```

6. Wait for the Pages workflow to complete.
7. Click ownership verification in Naver.
8. Submit:

```text
https://parksc9449-hash.github.io/codex-gemma-adsense-blog/sitemap.xml
https://parksc9449-hash.github.io/codex-gemma-adsense-blog/rss.xml
```

## Open registration pages

```powershell
.\scripts\open-search-registration.ps1
```
