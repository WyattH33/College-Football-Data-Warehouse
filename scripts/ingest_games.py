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
    import argparse

    parser = argparse.ArgumentParser(description="Ingest games JSON from the API and save to data/raw.")
    parser.add_argument("--season", type=int, default=2024, help="Season year (e.g., 2024)")
    parser.add_argument("--week", type=int, default=1, help="Week number (e.g., 1)")
    parser.add_argument("--seasonType", type=str, default="regular", help="Season type: regular, postseason, etc.")

    args = parser.parse_args()

    data = fetch_games(args.season, args.week, seasonType=args.seasonType)
    save_raw_games(data, args.season, args.week)
    print(f"Ingested games: season={args.season} week={args.week} seasonType={args.seasonType}")

