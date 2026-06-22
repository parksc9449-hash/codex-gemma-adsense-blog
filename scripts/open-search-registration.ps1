$PublicUrl = "https://parksc9449-hash.github.io/codex-gemma-adsense-blog/"
$SitemapUrl = "$PublicUrl" + "sitemap.xml"
$RssUrl = "$PublicUrl" + "rss.xml"

Write-Host "Public URL:  $PublicUrl"
Write-Host "Sitemap URL: $SitemapUrl"
Write-Host "RSS URL:     $RssUrl"

Start-Process "https://search.google.com/search-console/welcome"
Start-Process "https://searchadvisor.naver.com/console/board"
Start-Process $SitemapUrl
