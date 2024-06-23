CREATE TABLE IF NOT EXISTS public.sublists
(
    title text,
    id text primary key,
    author text,
    description text,
    created timestamptz,
    updated timestamptz,
    index int8[]
)

GRANT ALL ON public.sublists TO current_user;
