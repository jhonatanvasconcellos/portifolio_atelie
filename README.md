# 📱 Ateliê Portfólio App (Flutter)

Este é um aplicativo de catálogo de ateliê, construído em Flutter como um projeto de portfólio. O app permite que clientes visualizem modelos de roupas e tecidos disponíveis, salvem seus dados de cadastro e iniciem um pedido de encomenda diretamente pelo WhatsApp.

## ✨ Sobre o Projeto

O objetivo deste app é simular um catálogo de e-commerce real para um pequeno negócio (ateliê), focando em uma arquitetura de código limpa (Feature-based), gerenciamento de estado moderno (Riverpod) e um fluxo de usuário completo, desde a visualização do produto até a finalização do pedido.

## 🚀 Funcionalidades Implementadas (MVP)

* **Catálogo de Produtos:** Visualização de Modelos e Tecidos em uma grade 2x2.
* **Detalhes do Produto:** Galeria de fotos com swipe (`PageView`) e descrição detalhada.
* **Navegação Fluida:** Navegação principal com `BottomNavigationBar` e `PageView` (permitindo cliques e swipe).
* **Gerenciamento de Estado:** O estado global (seleção de itens, cadastro) é gerenciado com **Riverpod** (`StateNotifierProvider`).
* **Página "Infos" com Mídia:** Reprodução de vídeo (`video_player`) e informações de contato.
* **Persistência de Dados:** O cadastro do cliente (Nome, Endereço, etc.) é salvo localmente usando `shared_preferences`, persistindo mesmo se o app for fechado.
* **Fluxo de Finalização:** Lógica de "carrinho" que só habilita o botão de finalizar após a seleção de um modelo E um tecido.
* **Integração com API Externa:** Envio do pedido formatado diretamente para o **WhatsApp** da loja usando `url_launcher`.
* **Design System:** O app utiliza um sistema de design interno para cores (`AppColors`), espaçamento (`AppSpacing`) e tipografia (`AppTypography`), garantindo consistência.

## 🛠️ Tecnologias Utilizadas

* **Flutter** (SDK)
* **Dart** (Linguagem)
* **Riverpod** (Gerenciamento de Estado)
* **SharedPreferences** (Persistência de Dados Local)
* **url_launcher** (Integração com WhatsApp)
* **video_player** (Player de Vídeo Nativo)
* **google_fonts** (Tipografia)
* **font_awesome_flutter** (Iconografia)
* **smooth_page_indicator** (Indicadores de galeria)

## 🔮 Próximos Passos (Roadmap)

* [ ] Migrar o catálogo local (`mock_data.dart`) para um backend dinâmico (**Firebase Firestore** & **Storage**).
* [ ] Implementar animações de transição de página (Hero Animations).
* [ ] Adicionar funcionalidades de "Busca" e "Filtro" de produtos.

