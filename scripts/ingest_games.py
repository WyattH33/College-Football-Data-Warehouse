import os
import json
import requests
from dotenv import load_dotenv
load_dotenv()

# script to ingest raw data from regular season games week by week for a given year. 

API_KEY = os.getenv("CFB_API_KEY")

def fetch_games(year, week, seasonType="regular"):
    response = requests.get(
    "https://api.collegefootballdata.com/games",
    headers={"Authorization": f"Bearer {API_KEY}"},
    params={"year": year, "week": week, "seasonType": seasonType})
    response.raise_for_status()
    return response.json()

def save_raw_games(data, year, week):
    path = f"data/raw/games/year={year}/week={week}.json"
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w") as f:
        json.dump(data, f)

if __name__ == "__main__":
    year = 2024
    week = 1
    data = fetch_games(year, week)
    save_raw_games(data, year, week)
