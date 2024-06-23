CREATE TABLE IF NOT EXISTS public.sublist_channels
(
    id text NOT NULL,
    author text,
    updated timestamp with time zone,
    slid text references sublists(id),
    index int8,
    PRIMARY KEY (index, slid)
)

GRANT ALL ON TABLE public.sublist_channels TO current_user;
