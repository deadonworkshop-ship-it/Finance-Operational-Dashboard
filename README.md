# Finance Operational Dashboard

A single-page finance operations dashboard for personal use on iPhone (via Safari/Home Screen) with local-first storage.

## Current features
- Monthly bills tracking with paid/unpaid state and phase totals.
- Debt payment queue + posted debt payment history.
- Debt snapshot balances with total debt owed.
- Financial Planner page for:
  - monthly income by source
  - taxes withheld by source
  - investment balances
  - major upcoming expenses by due date
  - monthly roll-up showing estimated money left after plan items

## iPhone usability
Yes — this is usable on iPhone now as a web app when added to Home Screen.

### Known limitations
- Data is stored in browser `localStorage` only (no cloud sync or cross-device backup yet).
- Not a native App Store app yet.
- Offline reliability is limited without a service worker.

---

## Fastest start (one command)

From this project folder, run:

```bash
./run-local.sh
```

This prints both:
- a computer URL (`http://localhost:4173`)
- an iPhone URL (your local network IP) when detectable.

Then open the shown URL in your browser/Safari.

---

## Add income quickly from your spreadsheet
On the **Financial Planner** page:
1. Scroll to **Income + Taxes (Monthly)**.
2. Paste rows into **Bulk import rows** using this format:
   - `Income Name<TAB>Amount<TAB>Date`
   - example: `VA	$2,150.45	1/28/2026`
3. Tap **IMPORT PASTED INCOME**.

Notes:
- Header lines (like `Income Amount Date`) and `Total Income` rows are ignored.
- Dates can be `MM/DD/YYYY` or `YYYY-MM-DD`.
- If date is blank, the entry is assigned to the currently selected planner month.

---

## Investment buckets with dropdown accounts
On the **Financial Planner** page, investment tracking now works as fixed account buckets:
- Pick an account from the investment dropdown.
- Enter the latest balance and tap **UPDATE BALANCE**.
- Add a new account anytime with **Add account (optional)** + **ADD ACCOUNT**.
- Delete an account from the investment list with **DELETE** (this also removes saved balance history for that account).

This setup keeps your account buckets stable while letting balances be updated over time.

---

## Step-by-step: test on your computer

### 1) Open Terminal in this project folder
Make sure you are inside the folder that contains `index.html`.

### 2) Start a local web server
Run:

```bash
python3 -m http.server 4173
```

If this works, Terminal should show something like:

```text
Serving HTTP on 0.0.0.0 port 4173 ...
```

### 3) Open the app on your computer
In your browser, go to:

```text
http://localhost:4173
```

You should see the dashboard.

### 4) Stop the server when done
In the same Terminal window, press:

```text
Ctrl + C
```

---

## Step-by-step: test on your iPhone (same Wi-Fi)

### 1) Keep the server running on your computer
Leave this running:

```bash
python3 -m http.server 4173
```

### 2) Find your computer’s local IP address
Use one of these commands:

- macOS:
  ```bash
  ipconfig getifaddr en0
  ```
- Linux:
  ```bash
  hostname -I
  ```
- Windows (PowerShell):
  ```powershell
  ipconfig
  ```
  (look for IPv4 address)

Example IP: `192.168.1.25`

### 3) Open on iPhone Safari
On your iPhone (connected to the same Wi-Fi), open:

```text
http://<your-ip>:4173
```

Example:

```text
http://192.168.1.25:4173
```

### 4) Add to Home Screen
In Safari:
1. Tap **Share**
2. Tap **Add to Home Screen**
3. Launch from your Home Screen

---

## If iPhone cannot connect (quick troubleshooting)
- Confirm both phone and computer are on the same Wi-Fi network.
- Confirm the server is still running in Terminal.
- Try replacing `localhost` with your IP address from step 2.
- Temporarily allow incoming connections for Python in your firewall.
- Retry with `http://<your-ip>:4173/index.html`.

---

## Optional: test from anywhere (not same Wi-Fi)
Deploy this static app to GitHub Pages / Netlify / Vercel, then open that HTTPS URL on your phone and add it to Home Screen.

## Publish to GitHub so you can test from your phone anywhere

If you want a live URL from GitHub, use GitHub Pages.

### 1) Push this repo to GitHub
```bash
git remote add origin <your-github-repo-url>
git push -u origin HEAD
```

### 2) Enable GitHub Pages in the repo
1. Open your repo on GitHub.
2. Go to **Settings → Pages**.
3. Under **Build and deployment**, set **Source = GitHub Actions**.

This repo includes `.github/workflows/deploy-pages.yml`, which auto-deploys this static app on push to `main` or `master`.

### 3) Wait for the deploy workflow to finish
- Open the **Actions** tab and wait for **Deploy static site to GitHub Pages** to pass.

### 4) Open your live URL
Your app will be available at:

```text
https://<your-github-username>.github.io/<repo-name>/
```

Open that URL on iPhone Safari, then tap **Share → Add to Home Screen**.

---

## Native iPhone app path (next)
When you're ready, wrap this with Capacitor to ship as a real iOS app for yourself while reusing the existing UI/business logic.


## Start a completely new branch + PR
If you want to avoid conflict-heavy PRs, start from a fresh branch off `main`/`master`.

### One-command helper
```bash
./start-new-pr-branch.sh my-new-feature
```

Optional explicit base branch:
```bash
./start-new-pr-branch.sh my-new-feature main
```

This will:
- switch to your base branch,
- pull latest changes (when `origin` exists),
- create a brand-new feature branch,
- print next steps to push and open a new PR.

---

## If GitHub says this PR has conflicts
If you see **"This branch has conflicts that must be resolved"**, it usually means `main` changed after this branch was created.

### Fast path (script)
If you just want one command from your feature branch, run:

```bash
./fix-pr-conflicts.sh
```

- It auto-detects `main` or `master`.
- It fetches `origin` when available.
- It attempts the merge and tells you exactly what to do next.

You can also pass an explicit target branch:

```bash
./fix-pr-conflicts.sh main
```

### Option A (recommended): update your branch locally
From this repo folder:

```bash
git checkout work
# if your default branch is main, use main; if master, use master
git merge main
```

If Git reports conflicts, open each conflicted file and look for markers like:

```text
<<<<<<< HEAD
...your branch...
=======
...main branch...
>>>>>>> main
```

Keep the content you want, remove the markers, then run:

```bash
git add .
git commit -m "Resolve merge conflicts with main"
```

Push the branch again and GitHub will re-check mergeability.

### Option B: use GitHub conflict editor
On the PR page, click **Resolve conflicts**, edit the file in-browser, then mark as resolved and commit.

---

