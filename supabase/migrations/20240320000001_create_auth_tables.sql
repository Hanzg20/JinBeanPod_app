-- 启用 UUID 扩展
create extension if not exists "uuid-ossp";

-- 创建用户资料表
create table public.profiles (
  id uuid references auth.users on delete cascade not null primary key,
  email text unique not null,
  display_name text,
  avatar_url text,
  phone_number text,
  user_type text default 'user'::text not null check (user_type in ('user', 'provider', 'admin')),
  status text default 'active'::text not null check (status in ('active', 'inactive', 'banned')),
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 创建用户设置表
create table public.user_settings (
  id uuid references auth.users on delete cascade not null primary key,
  theme text default 'light'::text not null check (theme in ('light', 'dark', 'system')),
  language text default 'zh'::text not null check (language in ('zh', 'en')),
  notification_enabled boolean default true not null,
  email_notification boolean default true not null,
  sms_notification boolean default true not null,
  push_notification boolean default true not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 创建地址表
create table public.addresses (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references auth.users on delete cascade not null,
  address_type text not null check (address_type in ('home', 'work', 'other')),
  address_line1 text not null,
  address_line2 text,
  city text not null,
  state text not null,
  postal_code text not null,
  country text not null,
  is_default boolean default false not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 创建服务商资料表
create table public.provider_profiles (
  id uuid references auth.users on delete cascade not null primary key,
  business_name text not null,
  business_description text,
  business_phone text,
  business_email text,
  business_address text,
  service_areas text[],
  service_categories text[],
  verification_status text default 'pending'::text not null check (verification_status in ('pending', 'verified', 'rejected')),
  verification_documents text[],
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 启用行级安全策略
alter table public.profiles enable row level security;
alter table public.user_settings enable row level security;
alter table public.addresses enable row level security;
alter table public.provider_profiles enable row level security;

-- 创建 profiles 表策略
create policy "Public profiles are viewable by everyone"
  on public.profiles for select
  using ( true );

create policy "Users can insert their own profile"
  on public.profiles for insert
  with check ( auth.uid() = id );

create policy "Users can update their own profile"
  on public.profiles for update
  using ( auth.uid() = id );

-- 创建 user_settings 表策略
create policy "Public user settings are viewable by everyone"
  on public.user_settings for select
  using ( true );

create policy "Users can insert their own settings"
  on public.user_settings for insert
  with check ( auth.uid() = id );

create policy "Users can update their own settings"
  on public.user_settings for update
  using ( auth.uid() = id );

-- 创建 addresses 表策略
create policy "Users can view their own addresses"
  on public.addresses for select
  using ( auth.uid() = user_id );

create policy "Users can insert their own addresses"
  on public.addresses for insert
  with check ( auth.uid() = user_id );

create policy "Users can update their own addresses"
  on public.addresses for update
  using ( auth.uid() = user_id );

create policy "Users can delete their own addresses"
  on public.addresses for delete
  using ( auth.uid() = user_id );

-- 创建 provider_profiles 表策略
create policy "Provider profiles are viewable by everyone"
  on public.provider_profiles for select
  using ( true );

create policy "Providers can insert their own profile"
  on public.provider_profiles for insert
  with check ( auth.uid() = id );

create policy "Providers can update their own profile"
  on public.provider_profiles for update
  using ( auth.uid() = id );

-- 创建新用户触发器函数
create or replace function public.handle_new_user()
returns trigger as $$
begin
  -- 创建用户资料
  insert into public.profiles (id, email, display_name)
  values (new.id, new.email, new.raw_user_meta_data->>'display_name');
  
  -- 创建用户设置
  insert into public.user_settings (id)
  values (new.id);
  
  return new;
end;
$$ language plpgsql security definer;

-- 创建新用户触发器
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- 创建更新时间触发器函数
create or replace function public.handle_updated_at()
returns trigger as $$
begin
  new.updated_at = timezone('utc'::text, now());
  return new;
end;
$$ language plpgsql security definer;

-- 为所有表创建更新时间触发器
create trigger handle_updated_at
  before update on public.profiles
  for each row execute procedure public.handle_updated_at();

create trigger handle_updated_at
  before update on public.user_settings
  for each row execute procedure public.handle_updated_at();

create trigger handle_updated_at
  before update on public.addresses
  for each row execute procedure public.handle_updated_at();

create trigger handle_updated_at
  before update on public.provider_profiles
  for each row execute procedure public.handle_updated_at();

-- 创建业务索引
create index idx_profiles_email on profiles(email);
create index idx_profiles_phone on profiles(phone_number);
create index idx_profiles_user_type on profiles(user_type);
create index idx_provider_verification on provider_profiles(verification_status); 