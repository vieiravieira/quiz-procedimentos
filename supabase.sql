-- Quem Sabe a WI? — banco do jogo
-- Cole tudo no Supabase > SQL Editor > New query e clique em RUN.

create table if not exists public.perguntas (
  id uuid primary key default gen_random_uuid(),
  texto text not null,
  resposta boolean not null,
  explicacao text default '',
  wi text default '',
  ordem int default 0,
  criado_em timestamptz default now()
);

create table if not exists public.estado (
  id int primary key default 1,
  dados jsonb not null default '{}'::jsonb,
  atualizado_em timestamptz default now()
);

create table if not exists public.respostas (
  id text primary key,          -- <rodada>_<t1|t2>
  rodada text not null,
  time text not null,
  v boolean not null,
  criado_em timestamptz default now()
);

-- Acesso pelo site (chave anon). É um jogo interno: todos podem ler e escrever.
alter table public.perguntas enable row level security;
alter table public.estado    enable row level security;
alter table public.respostas enable row level security;

drop policy if exists "jogo_perguntas" on public.perguntas;
drop policy if exists "jogo_estado"    on public.estado;
drop policy if exists "jogo_respostas" on public.respostas;
create policy "jogo_perguntas" on public.perguntas for all to anon using (true) with check (true);
create policy "jogo_estado"    on public.estado    for all to anon using (true) with check (true);
create policy "jogo_respostas" on public.respostas for all to anon using (true) with check (true);

-- Tempo real (as telas se atualizam sozinhas)
do $$
begin
  begin alter publication supabase_realtime add table public.perguntas; exception when duplicate_object then null; end;
  begin alter publication supabase_realtime add table public.estado;    exception when duplicate_object then null; end;
  begin alter publication supabase_realtime add table public.respostas; exception when duplicate_object then null; end;
end $$;

insert into public.estado (id, dados) values (1, '{"fase":"lobby","ordem":[],"hist":[]}')
on conflict (id) do nothing;

-- Perguntas de exemplo (edite/apague pelo botão ✏️ Perguntas na tela da TV)
insert into public.perguntas (texto, resposta, explicacao, wi, ordem)
select * from (values
  ('WI significa Instrução de Trabalho.', true, 'WI = Work Instruction, a Instrução de Trabalho que diz como cada processo deve ser feito.', 'Geral', 1),
  ('Seguir a WI é opcional quando a operação está corrida.', false, 'A WI vale sempre, principalmente nos dias de pico. É ela que garante que todo mundo faça igual e certo.', 'Geral', 2),
  ('Na aduana, o motorista tem 3 chances de contagem antes de cair em aduana obrigatória.', false, 'São 2 contagens. Se errar a segunda, cai em aduana obrigatória.', 'WI SVC-217-76', 3),
  ('Se o motorista errar a 2ª contagem, ele cai em aduana obrigatória.', true, 'Errou a segunda contagem, a aduana passa a ser obrigatória.', 'WI SVC-217-76', 4),
  ('Se a tela não ficar verde, posso entregar o pacote ao motorista e avisar depois.', false, 'Tela não verde: separa o pacote e avisa na hora. Nada de entregar antes.', 'WI SVC-217-76', 5),
  ('O pacote separado só vai para o motorista depois da autorização de quem verificou.', true, 'Só entrega depois que quem verificou autorizar.', 'WI SVC-217-76', 6),
  ('Na dúvida na vaga, posso avisar o PS, o Assistente, o Analista ou a Coordenação, quem estiver mais perto.', true, 'Qualquer um deles pode ajudar. O importante é não seguir na dúvida.', 'Escalonamento', 7),
  ('Quando o time DHL precisa falar com o Mercado Livre, o primeiro contato é direto com o TL do Mercado Livre.', false, 'O primeiro contato é sempre a coordenação do turno. Só se não souber, aí vai no TL.', 'Escalonamento', 8)
) as v(texto, resposta, explicacao, wi, ordem)
where not exists (select 1 from public.perguntas);
