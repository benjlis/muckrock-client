import requests
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry
import pandas as pd

search_endpoint = "https://api.www.documentcloud.org/api/documents/search/"
query = {'q': '(covid OR coronavirus) AND user:muckrock-staff-659 AND ' +
              'created_at:["2019-12-01T00:00:00Z" TO "2020-10-01T00:00:00Z"]',
         'version': 2.0}

http = requests.Session()
http.mount("https://", HTTPAdapter(max_retries=Retry(backoff_factor=1)))
response = http.get(search_endpoint, params=query)
print(response.json())
results = response.json()["results"]
print(f'query: {query["q"]}')
print(f'result count: {response.json()["count"]}')
df = pd.DataFrame(results)
# print(response.json())
# df.to_csv('muckrock-ml-non-covid.csv', index=False, header=True)
# exit()

# iterate through next result set
search_endpoint = response.json()["next"]
while search_endpoint:
    print(f'{search_endpoint}')
    response = http.get(search_endpoint)
    print(f'{response.status_code=}')
    results = response.json()["results"]
    df = df.append(results, ignore_index=True, sort=False)
    search_endpoint = response.json()["next"]
df.to_csv('muckrock-ml-covid.csv', index=False, header=True)
