# Financeiro Tríade

Sistema de gestão financeira para obras, equipe fixa, contas a pagar/receber, fluxo de caixa e folha de pagamento — com login e dados salvos na nuvem via Supabase.

## Arquivos deste pacote

- `index.html` — o sistema completo (front-end). É o único arquivo que vai pro GitHub Pages.
- `supabase_setup.sql` — script para rodar no Supabase (cria a tabela e as permissões).
- `README.md` — este guia.

## Passo 1 — Configurar o Supabase

1. Entre no seu projeto em [supabase.com](https://supabase.com).
2. Vá em **SQL Editor** → cole o conteúdo de `supabase_setup.sql` → **Run**.
3. Vá em **Authentication → Users → Add user**. Cadastre o e-mail e senha que você e a funcionária vão usar (login único e compartilhado). Marque **"Auto Confirm User"**.
4. Vá em **Authentication → Settings** e desative **"Allow new user signups"** — assim ninguém consegue criar outro login além do que você cadastrou manualmente.
5. Vá em **Project Settings → API** e copie:
   - **Project URL**
   - **anon public key**

## Passo 2 — Configurar o `index.html`

Abra o arquivo `index.html` num editor de texto, procure por estas linhas (perto do início do bloco `<script>`):

```js
const SUPABASE_URL = "COLOQUE_SUA_SUPABASE_URL_AQUI";
const SUPABASE_ANON_KEY = "COLOQUE_SUA_SUPABASE_ANON_KEY_AQUI";
```

Substitua pelos valores copiados no Passo 1.5. Salve o arquivo.

## Passo 3 — Subir para o GitHub

1. Crie um repositório novo no GitHub (pode ser público — o código ficar visível não é um problema de segurança; quem protege os dados é o login + as regras do Supabase, não o sigilo do código).
2. Faça upload do `index.html` (mantendo esse nome, para abrir direto na raiz do site).
3. Vá em **Settings → Pages** do repositório.
4. Em "Source", selecione a branch principal (`main`) e a pasta raiz (`/`). Salve.
5. Aguarde alguns minutos — o GitHub mostra o link do site (algo como `https://seuusuario.github.io/seurepositorio/`).

## Passo 4 — Usar

Abra o link do GitHub Pages, entre com o e-mail e senha cadastrados no Passo 1.3. Os dados ficam salvos automaticamente no Supabase a cada alteração — acessíveis de qualquer computador com esse login.

## Backup

Mesmo com o Supabase, use de vez em quando o botão **"Exportar backup"** na barra lateral do sistema — ele baixa um `.json` com tudo, como uma cópia de segurança extra independente do banco de dados.

## Observação sobre segurança

O código do `index.html` fica público (é assim que GitHub Pages funciona). A proteção real dos dados vem de duas coisas:
- Sem login válido no Supabase, nenhuma leitura ou gravação é permitida (Row Level Security).
- Não existe cadastro público de novos usuários (login criado manualmente por você no painel do Supabase).

A chave "anon public key" que fica no código **não é secreta** — ela é feita para ficar em aplicações client-side; a Supabase foi projetada para isso.
