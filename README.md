# 🧠 Quem Sabe a WI?

Jogo de Verdadeiro ou Falso com 2 times e placar em % na TV.
Site estático (GitHub + Vercel) com banco em tempo real no Supabase.

## Arquivos

| Arquivo | Para que serve |
|---|---|
| `index.html` | O jogo inteiro (TV, Time 1 e Time 2) |
| `config.js` | Onde você cola a URL e a chave do Supabase |
| `supabase.sql` | Cria as tabelas e as perguntas de exemplo |

## Passo a passo

### 1. Supabase (banco, uns 5 min)
1. Entre em supabase.com e crie um projeto novo (ex.: `quem-sabe-a-wi`).
2. Vá em **SQL Editor → New query**, cole todo o conteúdo de `supabase.sql` e clique em **Run**.
3. Vá em **Project Settings → API** e copie a **Project URL** e a chave **anon public**.
4. Abra `config.js` e cole os dois valores no lugar de `COLE_AQUI...`.

### 2. GitHub
1. Crie um repositório novo (ex.: `quem-sabe-a-wi`).
2. Clique em **Add file → Upload files**, arraste os 4 arquivos (`index.html`, `config.js`, `supabase.sql`, `README.md`) e clique em **Commit changes**.

### 3. Vercel
1. Em vercel.com, clique em **Add New → Project** e importe o repositório.
2. Framework Preset: **Other**. Não precisa mudar mais nada. Clique em **Deploy**.
3. Pronto: o jogo fica em `https://quem-sabe-a-wi.vercel.app` (ou o nome que a Vercel der).

Toda vez que você alterar um arquivo no GitHub, a Vercel publica sozinha.

## No dia do jogo

| Computador | Link |
|---|---|
| Seu PC (espelhado na TV) | `https://SEU-SITE.vercel.app/#tv` |
| PC do Time 1 | `https://SEU-SITE.vercel.app/#time1` |
| PC do Time 2 | `https://SEU-SITE.vercel.app/#time2` |

- Na TV: **barra de espaço** ou o botão amarelo avança o jogo. Use **⛶ Tela cheia** (ou F11).
- **🔈 Ligar som** ativa tic-tac, acerto, "womp womp" e fanfarra.
- **✏️ Perguntas** abre o editor: adicionar, editar e excluir perguntas.
- **🧹 Reiniciar** zera o placar para um novo grupo (clique duas vezes).
- Ninguém precisa de login. Teste uma rodada com os 3 PCs antes de chamar a galera.

## Observação
Como não tem login, qualquer pessoa com o link consegue mexer no jogo. Para um treinamento interno isso é o normal. Só não divulgue o link fora da operação.
