import requests
import pandas as pd
import time

sleep_period = 5  # seconds to sleep between calls)
results = []
res = requests.get("https://api.www.documentcloud.org/api/organizations/")
print(f'count: {res.json()["count"]}')
while res.status_code == 200:
    results += res.json()["results"]
    print(f'next: {res.json()["next"]}')
    time.sleep(5)
    res = requests.get(res.json()["next"])
df = pd.DataFrame.from_dict(results)
df = pd.DataFrame(results)
print(df.head())
df.to_csv('muckrock-orgs.csv', index=False, header=True)
