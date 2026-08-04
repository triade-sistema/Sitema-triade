-- ============================================================
-- Financeiro Tríade — Setup do Supabase
-- Rode este script inteiro no SQL Editor do seu projeto Supabase
-- ============================================================

-- 1. Tabela única que guarda todos os dados do sistema (em formato JSON)
create table if not exists public.financeiro_dados (
  id text primary key default 'principal',
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- 2. Ativa a segurança por linha (Row Level Security)
alter table public.financeiro_dados enable row level security;

-- 3. Regras: só usuários logados (autenticados) podem ler/gravar
create policy "Usuarios autenticados podem ler"
on public.financeiro_dados for select
to authenticated
using (true);

create policy "Usuarios autenticados podem inserir"
on public.financeiro_dados for insert
to authenticated
with check (true);

create policy "Usuarios autenticados podem atualizar"
on public.financeiro_dados for update
to authenticated
using (true)
with check (true);

-- 4. Cria a linha inicial vazia (o sistema preenche o conteúdo sozinho)
insert into public.financeiro_dados (id, data) values ('principal', '{}'::jsonb)
on conflict (id) do nothing;

-- ============================================================
-- Depois de rodar este script:
-- 1. Vá em Authentication -> Users -> Add user
--    Crie o e-mail/senha que você e a funcionária vão usar,
--    marcando "Auto Confirm User".
-- 2. Vá em Authentication -> Settings e desative
--    "Allow new user signups" (recomendado, evita cadastros externos).
-- 3. Vá em Project Settings -> API e copie a "Project URL" e a
--    "anon public key" para colar no arquivo index.html
--    (constantes SUPABASE_URL e SUPABASE_ANON_KEY).
-- ============================================================
