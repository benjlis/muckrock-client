import requests
import pandas as pd
import time

sleep_period = 1  # seconds to sleep between calls)
per_page = 100    # of results to return per page


def gmrd(endpoint, rdtype):
    "Downloads MuckRock reference data and writes to a file"
    results = []
    res = requests.get(endpoint + f'?per_page={per_page}')
    print(f'{rdtype} count: {res.json()["count"]}')
    while res:
        results += res.json()["results"]
        next_pg = res.json()["next"]
        if not next_pg:
            break
        t = time.localtime()
        current_time = time.strftime("%H:%M:%S", t)
        print(f'{current_time}, status: {res.status_code} \
result cnt: {len(results)}')
        print(f'next: {next_pg}')
        time.sleep(sleep_period)
        attempt = 1
        res = requests.get(next_pg)
        while not res and attempt <= 10:
            attempt += 1
            time.sleep(sleep_period * 2)
            t = time.localtime()
            current_time = time.strftime("%H:%M:%S", t)
            print(f'{current_time}, attempt {attempt}')
            res = requests.get(next_pg)
    df = pd.DataFrame(results)
    print(df.head())
    df.to_csv(rdtype + '.csv', index=False, header=True)


# gmrd('https://api.www.documentcloud.org/api/organizations', 'orgs')
# gmrd('https://api.www.documentcloud.org/api/users', 'users')
gmrd('https://api.www.documentcloud.org/api/projects', 'projects')
