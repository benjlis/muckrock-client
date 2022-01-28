import requests
import json
import pandas as pd

search_endpoint = "https://api.www.documentcloud.org/api/documents/search/"
# query = {'q': 'covid', 'expand': 'user,organization'}
query = {'q': '(covid coronavirus "covid-19" "covid19" "covid 19" "sars-cov-2" "2019-ncov")'}
response = requests.get(search_endpoint, params=query)

results = response.json()["results"]
count = response.json()["count"]
next = response.json()["next"]

results_str = json.dumps(results, indent=2)
print(results_str)
print(f'count: {count}')
print(f'next: {next}')

df = pd.DataFrame.from_dict(response.json(), orient='index')
df = pd.DataFrame(results)
print(df.head())
df.to_csv('muckrock.csv', index=False, header=True)
