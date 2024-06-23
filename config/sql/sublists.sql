CREATE TABLE IF NOT EXISTS public.sublists
(
    title text,
    id text primary key,
    author text NOT NULL,
    description text,
    created timestamptz,
    subscriptions text[]
)

GRANT ALL ON public.sublists TO current_user;
