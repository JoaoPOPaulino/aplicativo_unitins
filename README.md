Aplicativo Acadêmico Unitins
O Aplicativo Acadêmico Unitins é uma solução desenvolvida em Flutter para gerenciar informações acadêmicas de estudantes, incluindo boletim, grade curricular, rematrícula online, situação acadêmica e análise curricular. Este projeto foi criado para simular um sistema de secretaria acadêmica, integrando dados de um servidor JSON local.
Funcionalidades

Boletim (Semestre Atual): Visualização das notas e frequências das disciplinas do semestre atual.
Grade Curricular: Exibição das disciplinas distribuídas por período para um curso específico.
Rematrícula Online: Processo de rematrícula com emissão de declaração de vínculo.
Situação Acadêmica: Detalhes sobre status da matrícula, pendências financeiras e acadêmicas.
Análise Curricular: Progresso do curso com barra de porcentagem e listas de disciplinas concluídas e pendentes.

Pré-requisitos

Flutter SDK (versão 3.x ou superior).
Dart (incluído com o Flutter).
JSON Server para simular a API.
Editor de código (ex.: VS Code com extensões Flutter e Dart).

Instalação

Clone o repositório:
git clone https://github.com/seu-usuario/aplicativo-unitins.git
cd aplicativo-unitins


Instale as dependências:
flutter pub get


Configure o JSON Server:

Certifique-se de ter o Node.js instalado.
Instale o JSON Server globalmente: npm install -g json-server


Coloque o arquivo db.json (fornecido no repositório) na raiz do projeto.
Inicie o servidor JSON: json-server --watch db.json


Sempre verifique a baseUrl nos serviços (padrão localhost:3000).


Execute o aplicativo:
flutter run -d chrome --debug


Ou use um emulador/device Android/iOS.



Estrutura do Projeto

lib/models/: Modelos de dados (ex.: Disciplina, Boletim).
lib/provider/: Providers para gerenciamento de estado (ex.: BoletimProvider, AnaliseCurricularProvider).
lib/screens/: Telas do aplicativo (ex.: DashboardScreen, AnaliseCurricularScreen).
lib/services/: Serviços para chamadas à API (ex.: AnaliseCurricularService).

Sobre o db.json
O arquivo db.json é a base de dados local que simula a API do sistema. Ele contém as seguintes seções:

boletim: Registros de notas, frequências e status de disciplinas por usuário.
users: Informações de login (nome, e-mail, senha) para 10 usuários.
grade_curricular: Lista de disciplinas com IDs, cursos ("Sistemas de Informação" e "Ciência da Computação"), períodos e cargas horárias (98 disciplinas no total).
situacao: Status acadêmico de cada usuário, incluindo matrícula, pendências (documentos, financeiras, acadêmicas) e última atualização.

Exemplo de uso:

Faça login com userId: 3 (e-mail: a, senha: a) para ver o progresso de João Pedro em "Sistemas de Informação".
Use userId: 4 (e-mail: maria@unitins.br, senha: m123) para verificar Maria Silva em "Ciência da Computação".

O arquivo deve ser atualizado conforme necessário para adicionar mais usuários ou disciplinas.
Contribuição

Faça um fork do repositório.
Crie uma branch para sua feature: git checkout -b feature/nova-funcionalidade.
Commit suas mudanças: git commit -m "Descrição da mudança".
Envie para o repositório: git push origin feature/nova-funcionalidade.
Abra um Pull Request.
