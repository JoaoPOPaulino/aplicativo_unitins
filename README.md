# 📚 Aplicativo Acadêmico Unitins - AV2 de Prog. para Dispositivos Móveis I

Uma solução completa desenvolvida em Flutter para gerenciamento de informações acadêmicas, simulando um sistema real de secretaria universitária.

## 🎯 Sobre o Projeto

O Aplicativo Acadêmico Unitins é uma aplicação móvel/web que permite aos estudantes acessar e gerenciar suas informações acadêmicas de forma prática e intuitiva. O sistema integra dados através de um servidor JSON local, oferecendo uma experiência completa de gestão acadêmica.

## ✨ Funcionalidades Principais

### 📊 **Boletim Acadêmico**
- Visualização das notas e frequências do semestre atual
- Acompanhamento do desempenho por disciplina
- Status de aprovação/reprovação

### 📅 **Grade Curricular**
- Exibição completa das disciplinas por período
- Organização por curso específico
- Informações de carga horária

### 🔄 **Rematrícula Online**
- Processo digitalizado de rematrícula
- Emissão automática de declaração de vínculo
- Interface intuitiva e simplificada

### 📋 **Situação Acadêmica**
- Status detalhado da matrícula
- Identificação de pendências financeiras
- Alertas sobre questões acadêmicas

### 📈 **Análise Curricular**
- Progresso visual do curso com barra de porcentagem
- Lista de disciplinas concluídas
- Disciplinas pendentes organizadas por período

## 🛠️ Tecnologias Utilizadas

- **Flutter** - Framework de desenvolvimento
- **Dart** - Linguagem de programação
- **JSON Server** - Simulação de API REST
- **Provider** - Gerenciamento de estado

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (versão 3.x ou superior)
- [Dart SDK](https://dart.dev/get-dart) (incluído com Flutter)
- [Node.js](https://nodejs.org/) (para JSON Server)
- Editor de código ([VS Code](https://code.visualstudio.com/) recomendado com extensões Flutter e Dart)

## 🚀 Instalação e Configuração

### 1. Clone o Repositório
```bash
git clone https://github.com/seu-usuario/aplicativo-unitins.git
cd aplicativo-unitins
```

### 2. Instale as Dependências
```bash
flutter pub get
```

### 3. Configure o JSON Server
```bash
# Instale o JSON Server globalmente
npm install -g json-server

# Certifique-se de que o arquivo db.json está na raiz do projeto
# Inicie o servidor JSON
json-server --watch db.json --port 3000
```

> ⚠️ **Importante:** Verifique se a `baseUrl` nos serviços está configurada corretamente (padrão: `localhost:3000`)

### 4. Execute a Aplicação
```bash
# Para executar no navegador
flutter run -d chrome --debug

# Para executar em emulador/dispositivo móvel
flutter run
```

## 📁 Estrutura do Projeto

```
lib/
├── models/           # Modelos de dados
│   ├── disciplina.dart
│   ├── boletim.dart
│   └── ...
├── providers/        # Gerenciamento de estado
│   ├── boletim_provider.dart
│   ├── analise_curricular_provider.dart
│   └── ...
├── screens/          # Telas da aplicação
│   ├── dashboard_screen.dart
│   ├── analise_curricular_screen.dart
│   └── ...
└── services/         # Serviços de API
    ├── analise_curricular_service.dart
    └── ...
```

## 🗃️ Base de Dados (db.json)

O arquivo `db.json` simula uma API REST completa com as seguintes seções:

### 📚 **Seções Principais**
- **`boletim`** - Registros de notas, frequências e status por usuário
- **`users`** - Dados de autenticação (10 usuários de teste)
- **`grade_curricular`** - 98 disciplinas distribuídas entre os cursos
- **`situacao`** - Status acadêmico e pendências de cada usuário

### 🎓 **Cursos Disponíveis**
- Sistemas de Informação
- Ciência da Computação

## 👥 Usuários de Teste

Para testar a aplicação, utilize os seguintes usuários:

| Usuário | E-mail | Senha | Curso | Descrição |
|---------|--------|--------|--------|-----------|
| João Pedro | `a` | `a` | Sistemas de Informação | Usuário com progresso avançado |
| Maria Silva | `maria@unitins.br` | `m123` | Ciência da Computação | Usuário com algumas pendências |

> 💡 **Dica:** Use `userId: 3` para João Pedro e `userId: 4` para Maria Silva

## 🔧 Desenvolvimento

### Adicionando Novos Usuários
1. Edite o arquivo `db.json`
2. Adicione novos registros nas seções `users`, `boletim` e `situacao`
3. Reinicie o JSON Server

### Adicionando Disciplinas
1. Localize a seção `grade_curricular` no `db.json`
2. Adicione novas disciplinas seguindo o padrão existente
3. Atualize os registros de `boletim` conforme necessário

## 🤝 Como Contribuir

Contribuições são sempre bem-vindas! Siga estes passos:

1. **Fork** o repositório
2. **Clone** seu fork localmente
3. **Crie** uma branch para sua feature:
   ```bash
   git checkout -b feature/nova-funcionalidade
   ```
4. **Commit** suas mudanças:
   ```bash
   git commit -m "feat: adiciona nova funcionalidade"
   ```
5. **Push** para seu repositório:
   ```bash
   git push origin feature/nova-funcionalidade
   ```
6. **Abra** um Pull Request

### 📝 Padrões de Commit
- `feat:` - Nova funcionalidade
- `fix:` - Correção de bug
- `docs:` - Documentação
- `style:` - Formatação de código
- `refactor:` - Refatoração
- `test:` - Testes

## 📞 Suporte

Se encontrar algum problema ou tiver dúvidas:

1. Verifique se o JSON Server está rodando
2. Confirme se todas as dependências foram instaladas
3. Verifique a configuração da `baseUrl`
4. Abra uma [issue](https://github.com/seu-usuario/aplicativo-unitins/issues) no repositório

---

Alunos: João Pedro de Oliveira e João Victor.
