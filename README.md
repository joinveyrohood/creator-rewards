# Creator Rewards Platform

A transparent content creator rewards platform (Kaito-inspired but simpler).

## What's Included

| File | Description |
|------|-------------|
| `schema.sql` | Full Supabase schema (users, campaigns, submissions, rewards, leaderboard view) |
| `SPEC.md` | Complete feature list, user flows, scoring formula, tech stack |
| `index.html` | Live dark-neon prototype (open in browser) |

## Quick Start

1. **Supabase**
   - Create new project
   - Run `schema.sql` in SQL Editor

2. **Frontend**
   - Open `index.html` to see the vibe
   - Or scaffold Next.js and use the same Tailwind colors:
     - Background: `#07080a`
     - Surface: `#0e1014`
     - Accent: `#CCFF00`

3. **Next Steps to Make It Real**
   - Next.js + Supabase client
   - Wallet connect (RainbowKit)
   - Campaign create/edit form
   - Submission form + admin scoring panel
   - Realtime leaderboard

## Scoring (Transparent)

```
Score = (Likes × 1) + (Retweets × 2) + (Replies × 1.5) + Uniqueness Bonus
```

Weights are customizable per campaign.

## Reward Types
- Points
- WL spots
- NFT / OG
- Token / USDC (manual claim)

Built for low-capital deployment on Vercel + Supabase.
