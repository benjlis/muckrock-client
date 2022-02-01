# muckrock-client
Simple Python client for MuckRock API

--
Status (2/1/2022):
* Seems to be limited to 100 calls (10000 elements) by documentcloud
* Will revisit if grant comes through
--
Invoking via curl
```
curl https://api.www.documentcloud.org/api/documents/search/\?q=covid | \
    python -m json.tool | more
curl https://api.www.documentcloud.org/api/documents/20985396/ | \
    python -m json.tool
```
