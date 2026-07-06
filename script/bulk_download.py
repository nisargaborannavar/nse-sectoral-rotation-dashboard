


import requests
import zipfile
import os
import time
from datetime import date, timedelta

# ─────────────────────────────────────────────
# SETTINGS
# ─────────────────────────────────────────────
START_DATE = date(2022, 1, 1)
END_DATE   = date(2024, 12, 31)
SAVE_FOLDER = "../data/raw"          # all CSVs will go here

os.makedirs(SAVE_FOLDER, exist_ok=True)

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
}

# ─────────────────────────────────────────────
# HELPER — build NSE URL for a given date
# ─────────────────────────────────────────────
def get_url(d):
    day   = d.strftime("%d")
    month = d.strftime("%b").upper()
    year  = d.strftime("%Y")
    fname = f"cm{day}{month}{year}bhav.csv.zip"
    return f"https://archives.nseindia.com/content/historical/EQUITIES/{year}/{month}/{fname}", fname

# ─────────────────────────────────────────────
# MAIN DOWNLOAD LOOP
# ─────────────────────────────────────────────
current   = START_DATE
success   = 0
skipped   = 0
failed    = 0
total_days = (END_DATE - START_DATE).days + 1

print("=" * 55)
print("  NSE BULK DOWNLOAD — 2022 to 2024")
print("=" * 55)
print(f"Saving CSVs to: {SAVE_FOLDER}")
print("Starting...\n")

while current <= END_DATE:

    # Skip weekends — NSE doesn't trade on Sat/Sun
    if current.weekday() >= 5:
        current += timedelta(days=1)
        continue

    url, zip_name = get_url(current)
    csv_name = zip_name.replace(".zip", "")
    csv_path = os.path.join(SAVE_FOLDER, csv_name)

    # Skip if already downloaded
    if os.path.exists(csv_path):
        skipped += 1
        current += timedelta(days=1)
        continue

    try:
        r = requests.get(url, headers=HEADERS, timeout=15)

        if r.status_code == 200:
            # Save zip temporarily
            zip_path = os.path.join(SAVE_FOLDER, zip_name)
            with open(zip_path, "wb") as f:
                f.write(r.content)

            # Extract CSV
            with zipfile.ZipFile(zip_path, "r") as z:
                z.extractall(SAVE_FOLDER)

            # Delete zip, keep CSV
            os.remove(zip_path)

            success += 1
            print(f"✅ {current.strftime('%d %b %Y')}  [{success} downloaded]")

        else:
            # 404 = holiday or non trading day, skip silently
            failed += 1

    except Exception as e:
        print(f"⚠️  {current.strftime('%d %b %Y')} — Error: {e}")
        failed += 1

    # Wait 0.5 seconds between requests so NSE doesn't block us
    time.sleep(0.5)
    current += timedelta(days=1)

# ─────────────────────────────────────────────
# SUMMARY
# ─────────────────────────────────────────────
print("\n" + "=" * 55)
print("  DOWNLOAD COMPLETE")
print("=" * 55)
print(f"✅ Downloaded : {success} files")
print(f"⏭️  Skipped    : {skipped} (already existed)")
print(f"❌ Failed     : {failed} (holidays/errors)")
print(f"\nAll CSV files saved in: {SAVE_FOLDER}")
