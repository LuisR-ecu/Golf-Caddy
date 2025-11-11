create extension if not exists "uuid-ossp";

create table if not exists users(
    id uuid primary key default uuid_generate_v4(),
    email text unique not null,
    created_at timestamptz default now()
);

create table if not exists clubs(
    id serial primary key,
    user_id uuid references users(id) on delete cascade,
    name text not null,
    loft real,
    typical_distance real
);

create table if not exists shots(
    id serial primary key,
    user_id uuid references users(id) on delete cascade,
    club_id int references clubs(id),
    carry real,
    wind_speed real,
    wind_dir_deg real,
    temperature real,
    elevation real,
    lie text,
    dispersion_left_right real,
    result text,
    created_at timestamptz defualt now()
);

create table if not exists swings(
    id serial primary key,
    user_id uuid references users(id) on delete cascade,
    video_url text,
    keyframes jsonb, -- timestamps for address/backswing/impact/followthrough
    metrics jsonb, -- angels, hips/shoulder turn, tempo
    cv_feedback text,
    created_at timestamptz default now()
);

-- for rag doc metadata
create table if not exists documents(
    id serial primary key,
    source text, -- 'pdf', 'blog', etc.
    uri text,   -- supabase storage path
    chunk_id int,
    text text,
    embedding vector(1536) -- pgvector in Supabase uses 1536 dimensions for OpenAI embeddings
)