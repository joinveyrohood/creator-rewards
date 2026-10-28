# Creator Rewards Platform - Full MVP Spec

## Overview
A Kaito-inspired but simpler platform for running content creator campaigns on X with transparent scoring and flexible rewards (Points / WL / NFT / Token).

**Vibe:** Dark degen (#07080a bg, lime #CCFF00 accent, glitchy neon)

---

## User Roles
1. **Creator** — Connect X + Wallet, submit posts, track score
2. **Admin / Project Owner** — Create campaigns, review submissions, score, distribute rewards
3. **Future:** Multi-project (open platform)

---

## Core Pages

### 1. Landing Page
- Hero: "Run Creator Campaigns. Reward Real Content."
- Live campaigns grid
- How it works (3 steps)
- CTA: View Campaigns / Create Campaign

### 2. Campaigns List
- Filter: Live / Upcoming / Ended
- Card: Title, reward pool, ends in, participants, status badge

### 3. Campaign Detail
- Full brief
- Reward breakdown
- Scoring rules (transparent)
- Submit Post button
- Live Leaderboard (top 20)
- My submissions

### 4. Submit Modal
- Paste X post URL
- Auto-extract post ID
- Confirm wallet
- Status: Pending → Scored

### 5. Leaderboard (Global or per campaign)
- Rank | Username | Score | Submissions | Wallet (truncated)

### 6. Admin Dashboard
- Create / Edit Campaign
- Pending submissions queue
- Manual score input (likes, RTs, replies, uniqueness)
- Approve / Reject
- Generate rewards

### 7. Profile / My Earnings
- Connected X + Wallet
- Total points
- Claimable rewards

---

## Scoring Formula (Transparent)

```
Base Score = (Likes × 1) + (Retweets × 2) + (Replies × 1.5)
Uniqueness Bonus = +5 to +15 (admin judged or simple duplicate check)
Final Score = Base + Bonus
```

Campaign owner can customize weights in `scoring_rules` jsonb.

---

## Reward Types Supported
- Points (internal)
- WL spots
- Free NFT / OG role
- Token (manual claim)
- USDC (manual)
- Mixed

---

## Tech Stack
- **Frontend:** Next.js + Tailwind + Framer Motion
- **Backend:** Supabase (Auth, DB, Realtime)
- **Wallet:** RainbowKit / Wagmi
- **Hosting:** Vercel
- **Future:** X API or scraper for auto metrics

---

## Next Build Steps
1. Supabase project + run schema.sql
2. Next.js app with dark theme
3. Auth (X OAuth or just wallet + manual X username)
4. Campaign CRUD
5. Submission + Leaderboard
6. Admin scoring panel
