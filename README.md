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

## Run locally
Open `index.html` directly, or serve with:

```bash
python3 -m http.server 4173
```

Then open in Safari and use **Share → Add to Home Screen**.

## Native iPhone app path (next)
When you're ready, wrap this with Capacitor to ship as a real iOS app for yourself while reusing the existing UI/business logic.
