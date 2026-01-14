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


from pathlib import Path

def save_raw_games(data, season, week, force=False):
    output_path = Path(f"data/raw/games/season={season}/week={week}.json")

    if output_path.exists() and not force:
        print(f"File exists: {output_path}. Use --force to overwrite.")
        return



    output_path.parent.mkdir(parents=True, exist_ok=True)

    with open(output_path, "w") as f:
        json.dump(data, f)

    print(f"Saved raw games to {output_path}")



if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Ingest games JSON from the API and save to data/raw.")
    parser.add_argument("--season", type=int, default=2024, help="Season year (e.g., 2024)")
    parser.add_argument("--week", type=int, default=1, help="Week number (e.g., 1)")
    parser.add_argument("--seasonType", type=str, default="regular", help="Season type: regular, postseason, etc.")
    parser.add_argument("--force", action="store_true", help="Overwrite existing raw files")


    args = parser.parse_args()

    data = fetch_games(args.season, args.week, seasonType=args.seasonType)
    # inside __main__
    save_raw_games(data, args.season, args.week, force=args.force)
    print(f"Ingested games: season={args.season} week={args.week} seasonType={args.seasonType}")

