-- ============================================
-- Creator Rewards Platform - Supabase Schema
-- Dark neon degen style (VeyroHood inspired)
-- ============================================

-- Enable extensions
create extension if not exists "uuid-ossp";

-- ==================== USERS ====================
create table if not exists public.users (
  id uuid primary key default uuid_generate_v4(),
  x_username text unique,
  wallet_address text unique,
  total_points numeric default 0,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- ==================== CAMPAIGNS ====================
create table if not exists public.campaigns (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  description text,
  brief text,
  reward_pool text, -- e.g. "500 WL spots", "1000 Points", "10 NFTs"
  reward_type text check (reward_type in ('points', 'wl', 'nft', 'token', 'usdc', 'mixed')),
  start_date timestamptz,
  end_date timestamptz,
  status text default 'draft' check (status in ('draft', 'live', 'ended', 'paused')),
  max_submissions_per_user int default 5,
  scoring_rules jsonb default '{"likes": 1, "retweets": 2, "replies": 1.5, "uniqueness_bonus": 5}'::jsonb,
  created_by uuid references public.users(id),
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- ==================== SUBMISSIONS ====================
create table if not exists public.submissions (
  id uuid primary key default uuid_generate_v4(),
  campaign_id uuid references public.campaigns(id) on delete cascade,
  user_id uuid references public.users(id),
  x_post_url text not null,
  x_post_id text,
  likes int default 0,
  retweets int default 0,
  replies int default 0,
  score numeric default 0,
  status text default 'pending' check (status in ('pending', 'approved', 'rejected', 'scored')),
  submitted_at timestamptz default now(),
  scored_at timestamptz,
  notes text
);

-- ==================== LEADERBOARD VIEW ====================
create or replace view public.campaign_leaderboard as
select 
  s.campaign_id,
  s.user_id,
  u.x_username,
  u.wallet_address,
  sum(s.score) as total_score,
  count(s.id) as submission_count,
  rank() over (partition by s.campaign_id order by sum(s.score) desc) as rank
from public.submissions s
join public.users u on u.id = s.user_id
where s.status = 'scored'
group by s.campaign_id, s.user_id, u.x_username, u.wallet_address;

-- ==================== REWARDS ====================
create table if not exists public.rewards (
  id uuid primary key default uuid_generate_v4(),
  campaign_id uuid references public.campaigns(id),
  user_id uuid references public.users(id),
  rank int,
  reward_amount text,
  reward_type text,
  claimed boolean default false,
  claimed_at timestamptz,
  created_at timestamptz default now()
);

-- Indexes
create index if not exists idx_submissions_campaign on public.submissions(campaign_id);
create index if not exists idx_submissions_user on public.submissions(user_id);
create index if not exists idx_submissions_status on public.submissions(status);
create index if not exists idx_campaigns_status on public.campaigns(status);

-- Updated at trigger
create or replace function update_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger users_updated_at before update on public.users
for each row execute function update_updated_at();

create trigger campaigns_updated_at before update on public.campaigns
for each row execute function update_updated_at();
