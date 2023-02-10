---
theme: uncover
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

<style>
:root {
	--color-highlight-heading: #ff921e;
}

.columns {
	display: grid;
	grid-template-columns: repeat(2, minmax(0, 1fr));
	gap: 1rem;
  	background:linear-gradient(#000,#000) center/2px 100% no-repeat;
}
</style>

# **CI/CD com <br> Github actions**

Orador: João Capucho

![bg right:30% 80%](assets/github-actions-logo.svg)

---

# O que é o **Glua**?

![bg right:30% 80%](assets/glua-logo.svg)

---

# O que é o **CI/CD**?

![](assets/ci-cd-flow.webp)

<div class="columns">
<div>

##### **Continuous Integration**

Automatização da integração de mudanças num projeto de software

</div>
<div>

##### **Continuous Deployment**

Automatização da entrega do projeto de software

</div>
</div>

---

# Qual é o **benefício**?

- Testagem frequente do código
- Entrega regular de funcionalidades e bugfixes
- Aumento da produtividade

---

<!-- _backgroundImage: none -->

![bg right:40%](assets/github-actions-landing-page.png)

# **Github actions**

- Oferta do Github para automatização e CI/CD
- Configuração fácil através de ficheiros YAML

---

# **Workflows**

- Ficheiros de configuração para as github actions
- Definidos no diretório `.github/workflows`
- Escritos em YAML (extensão `.yml`)

---

# Exemplo

```yml
name: Github action 101
run-name: Github action do workshop do glua
on: [push, workflow_dispatch]
jobs:
  cat-hello:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: cat hello
```

---

# **Events**

Um event dita quando é que um workflow é executado

- Definidos no campo `on: `
- Um workflow pode ter um ou mais events
- Existem events para quase tudo: novos commits, release criado, ativação manual, ...
- Algums events têm argumentos para filtrar o event

---

<style scoped>
pre {
	margin: 0;
}
</style>

# Exemplos

- Ativação manual

	```yml
	on: workflow_dispatch
	```

- Novos commits em qualquer branch

	```yml
	on: push 
	```

- Novos commits no branch `main`

	```yml
	on:
	  push:
		branches:
		  - 'main'
	```
---

# **Jobs**

Um job é um conjunto de **steps** que são executados sequencialmente.

- Definidos no campo `jobs: `
- Um workflow pode ter um ou mais jobs
- Os jobs podem ser executados em pararelo ou ter dependências entre si

---

# **Steps**

Um step pode ser código da linha de comandos ou uma **action**.

- Definidos no campo `steps: ` de um job
- Passos na linha de comando usam a diretiva `run: ` 
- Actions usam a diretiva `uses: ` 
- Um nome pode ser dado no campo `name: `

---

# **Actions**

Uma action é uma aplicação desenhada para fazer tarefas mais complexas no github actions.

- Estas podem carregar o nosso repositório ou instalar uma versão do python
- Podemos escrever as nossas próprias actions...
- ...ou ~~copiar~~ usar uma já feita
- Existem mais de 10000 actions no marketplace do github ([Marketplace actions](https://github.com/marketplace?type=actions))

---

# Exemplo

```yml
jobs:
  cat-hello:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v3
      - name: Mostrar o banner
        run: cat hello
  install-python:
    runs-on: ubuntu-latest
    steps:
      - name: Set up Python 3.9
        uses: actions/setup-python@v4
        with:
          python-version: 3.9
```

---

# Casos práticos

- Workflow de testagem automática com python
- Workflow de build e deployment de um site React para as github pages
- Perfis do github dinâmicos

---

# Custos

- As github actions são grátis para repositórios públicos
- Os repositórios privados são cobrados ao minuto
	- Contas no plano grátis têm 2000 minutos/mês
	- Contas no plano Pro têm 3000 minutos/mês
	- Minutos extra têm um custo acrescido
- Para os estudantes UA o github education dá acesso ao plano Pro de graça

---

# **Pausa para questões**

---

# Casos de uso **avançados**

- Integração com pull requests
- Matrizes de jobs
- Caching entres execuções de workflows
