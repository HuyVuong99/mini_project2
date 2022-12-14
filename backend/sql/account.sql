create table history_bets
(
    id           serial primary key ,
    email        text,
    username     text,
    score        integer default 0,
    password     text,
    role         text

);


INSERT INTO public.account (id, username, email, password, role, score) VALUES (6, 'SonNH', 'sonnh@otani-trading.com', 'sonnh123', 'user', 0);
INSERT INTO public.account (id, username, email, password, role, score) VALUES (4, 'SonDH', 'sondh@otani-trading.com', 'sondh123', 'user', 0);
INSERT INTO public.account (id, username, email, password, role, score) VALUES (10, 'SonPH', 'sonph@otani-trading.com', 'sonph123', 'user', 0);
INSERT INTO public.account (id, username, email, password, role, score) VALUES (1, 'Huy', 'huyvd@otani-trading.com', 'huyvd123', 'admin', 0);
INSERT INTO public.account (id, username, email, password, role, score) VALUES (7, 'My', 'myth@otani-trading.com', 'myth123', 'user', 11);
INSERT INTO public.account (id, username, email, password, role, score) VALUES (8, 'Phuoc', 'phuocnh@otani-trading.com', 'phuocnh123', 'user', 14);
INSERT INTO public.account (id, username, email, password, role, score) VALUES (5, 'Duyen', 'duyendt@otani-trading.com', 'duyendt123', 'user', 10);
INSERT INTO public.account (id, username, email, password, role, score) VALUES (12, 'SonTT', 'sontt@otani-trading.com', 'sontt123', 'user', 6);
INSERT INTO public.account (id, username, email, password, role, score) VALUES (9, 'Nhat', 'nhatnk@otani-trading.com', 'nhatnk123', 'user', 7);
INSERT INTO public.account (id, username, email, password, role, score) VALUES (3, 'Thuy', 'thuylt@otani-trading.com', 'thuylt123', 'user', 7);
INSERT INTO public.account (id, username, email, password, role, score) VALUES (2, 'Tung', 'tunght@otani-trading.com', 'tunght123', 'user', 12);
INSERT INTO public.account (id, username, email, password, role, score) VALUES (11, 'QuanHC', 'quanhc@otani-trading.com', 'quanhc123', 'user', 8);
INSERT INTO public.account (id, username, email, password, role, score) VALUES (13, 'Bang', 'bangtx@otani-trading.com', 'bangtx123', 'user', 10);
